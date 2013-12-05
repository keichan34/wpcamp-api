attributes :id, :guid, :url, :title, :address

node :dates do |object|
  {
    start: object.start,
    :end => object.end
  }
end
