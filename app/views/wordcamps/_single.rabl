attributes :id, :guid, :url, :title, :address

node :dates do |object|
  {
    start: object.start,
    :end => object.end
  }
end

node :thumbnail do |object|
  Hash[ [:original, :thumb ].map { |e| [e, asset_url(object.thumbnail.url(e))] } ]
end

if @include_banners
  node :banners do |object|
    object.banners.map { |e| {
      title: e.title,
      alt: e.alt,
      width: e.width,
      height: e.height,
      banner: image_url(e.banner.url(:original)),
      banner_updated_at: e.banner_updated_at,
      guid: e.guid
    } }
  end
end
