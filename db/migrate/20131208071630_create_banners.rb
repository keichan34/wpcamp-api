class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.integer :width
      t.integer :height
      t.string :alt

      t.integer :word_camp_id, null: false

      t.attachment :banner

      t.timestamps
    end

    add_index :banners, :word_camp_id
  end
end
