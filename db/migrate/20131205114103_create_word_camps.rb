class CreateWordCamps < ActiveRecord::Migration
  def change
    create_table :word_camps do |t|
      t.string :title

      t.string :url
      t.string :address

      t.date :start
      t.date :end

      t.string :guid, null: false
      t.timestamps
    end

    add_index :word_camps, :guid, unique: true
  end
end
