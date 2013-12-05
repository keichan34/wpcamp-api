require 'open-uri'

class Importer::WordcampCentral

  def self.run *args
    x = self.new
    x.run *args
  end

  def run args={}
    require 'thread/pool'

    args = {
      max_pages: 10
    }.merge args

    @max_pages = args[:max_pages]
    @pool = Thread.pool 4

    time_started = Time.now.utc

    if last_fetch_time = Metadata['wordcamp_central_last_fetch_time']
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

    @pool.shutdown

    # Metadata['wordcamp_central_last_fetch_time'] = time_started.to_s

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

        url = item.xpath('link').text.strip
        @pool.process do
          doc = Nokogiri::HTML open(url)

          wc.url = doc.css('.wc-single-website').first.attributes['href'].value rescue nil

          doc.css('.wc-single-info').children.each_with_index do |child, i|
            content = doc.css('.wc-single-info').children[i+1].text.strip rescue ''
            if child.text.strip == 'Date'
              if /^(?<month>.*?)\s+(?<day_from>\d{1,2})(-(?<day_to>\d{1,2}))?\s*,?\s*(?<year>\d{4})$/ =~ content
                wc.start = Date.parse "#{ month } #{ day_from }, #{ year }"

                wc.end = Date.parse "#{ month } #{ day_to }, #{ year }" if day_to
              end
            elsif child.text.strip == 'Location'
              wc.address = content
            end
          end

          wc.save!
        end

      end

      fetch_page (current_page_no + 1) if current_page_no < @max_pages
    end

end
