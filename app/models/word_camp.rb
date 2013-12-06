class WordCamp < ActiveRecord::Base

  # Since this data is generated automatically, there's no problem if it's in reduced redundancy.
  has_attached_file :thumbnail, styles: { large: ['800x800>', :jpeg], thumb: ['410x308#', :jpeg] }, s3_storage_class: :reduced_redundancy

end
