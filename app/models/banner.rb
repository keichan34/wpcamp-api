class Banner < ActiveRecord::Base
  belongs_to :word_camp

  has_attached_file :banner

  attr_accessor :delete_banner
  before_validation { banner.clear if delete_banner == '1' }

  validates :title, presence: true
  validates :width, numericality: { only_integer: true, greater_than: 0 }
  validates :height, numericality: { only_integer: true, greater_than: 0 }

  validates_attachment :banner, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/pjpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }

end
