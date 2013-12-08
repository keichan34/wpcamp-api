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

  after_post_process :save_banner_dimensions

  private

    def save_banner_dimensions
      geo = Paperclip::Geometry.from_file(banner.queued_for_write[:original])
      self.width = geo.width.to_i unless self.width and self.width > 0
      self.height = geo.height.to_i unless self.height and self.height > 0
    end

end
