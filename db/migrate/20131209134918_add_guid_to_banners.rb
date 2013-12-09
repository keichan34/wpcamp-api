class AddGuidToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :guid, :string
  end

  def migrate direction
    super

    if direction == :up
      Banner.reset_column_information

      Banner.all.each do |banner|
        banner.reset_guid!
      end
    end
  end
end
