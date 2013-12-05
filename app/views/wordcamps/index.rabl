object false

node :wordcamps do
  partial 'wordcamps/single', object: @wordcamps
end

node :meta do
  {
    current_page: @wordcamps.current_page,
    total_pages: @wordcamps.total_pages
  }
end
