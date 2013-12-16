object false

node :wordcamps do
  @wordcamps.map { |e| { title: e.title, slug: e.title_for_slug } }
end

node :meta do
  Hash[]
end
