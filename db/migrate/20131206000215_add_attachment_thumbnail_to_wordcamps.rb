class AddAttachmentThumbnailToWordcamps < ActiveRecord::Migration
  def self.up
    change_table :word_camps do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    drop_attached_file :wordcamps, :thumbnail
  end
end
