class AddIndexOnWordCamps < ActiveRecord::Migration
  def change
    add_index :word_camps, :created_at
  end
end
