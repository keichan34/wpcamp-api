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
