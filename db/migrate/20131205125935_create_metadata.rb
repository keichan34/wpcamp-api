class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.string :key, null: false
      t.text :value
    end

    add_index :metadata, :key, unique: true
  end
end
