require 'open-uri'

class Importer::WordcampCentral

  def self.run *args
    x = self.new
    x.run *args
  end

  def run args={}
    args = {
      max_pages: 10,
      force: false
    }.merge args

    @max_pages = args[:max_pages]

    time_started = Time.now.utc

    if last_fetch_time = Metadata['wordcamp_central_last_fetch_time'] and !args[:force]
      last_fetch_time = Time.parse(last_fetch_time).utc
    else
      last_fetch_time = 20.years.ago.utc
    end

    # Start.
    # - Page 1.
    url = "http://central.wordcamp.org/feed/?post_type=wordcamp"
    doc = Nokogiri::XML open(url)
    lastBuildDate = Time.parse doc.xpath('/rss/channel/lastBuildDate').first.text rescue nil
    if lastBuildDate and lastBuildDate >= last_fetch_time
      process_doc doc
    end

    Metadata['wordcamp_central_last_fetch_time'] = time_started.to_s

  end

  private

    def fetch_page page_no=1

      url = "http://central.wordcamp.org/feed/?post_type=wordcamp&paged=#{ page_no }"
      doc = Nokogiri::XML open(url)
      process_doc doc, page_no

    end

    def process_doc doc, current_page_no=1
      doc.xpath('/rss/channel/item').each do |item|
        guid = item.xpath('guid').text.strip
        wc = WordCamp.where( guid: guid ).first_or_initialize

        wc.created_at = Time.parse item.xpath('pubDate').text.strip
        wc.title = item.xpath('title').text.strip
        wc.description = item.xpath('content:encoded').text

        url = item.xpath('link').text.strip

        doc = Nokogiri::HTML open(url)

        wc.url = doc.css('.wc-single-website').first.attributes['href'].value rescue nil

        image_uri = doc.css('.wc-single-website > img').first.attributes['src'].value rescue nil
        if image_uri and (!wc.thumbnail? or (wc.thumbnail_updated_at and wc.thumbnail_updated_at <= 1.week.ago))
          image_uri.gsub! /\?.*?$/, ''
          wc.thumbnail = URI.parse image_uri
        end

        cursor = nil
        attrs = {}
        doc.css('.wc-single-info').children.each do |child|
          # start a new cursor
          if child['class'] == 'wc-single-label'
            cursor = child.text.downcase.to_sym
            attrs[cursor] = []
          elsif cursor != nil
            attrs[cursor] << child
          end
        end

        attrs = Hash[attrs.map { |key, value| [key, value.map { |e| e.text }.join('').strip.gsub(/\s+/, ' ') ] }]

        if content = attrs[:date]
          if /^(?<month>.*?)\s+(?<day_from>\d{1,2})(-(?<day_to>\d{1,2}))?\s*,?\s*(?<year>\d{4})$/ =~ content
            wc.start = Date.parse "#{ month } #{ day_from }, #{ year }"

            if day_to
              wc.end = Date.parse "#{ month } #{ day_to }, #{ year }"
            else
              wc.end = nil
            end
          end
        end

        if content = attrs[:location]
          wc.address = content
        end

        wc.save!
      end

      fetch_page (current_page_no + 1) if current_page_no < @max_pages
    end

end
