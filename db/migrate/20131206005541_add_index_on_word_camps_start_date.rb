class AddIndexOnWordCampsStartDate < ActiveRecord::Migration
  def change
    add_index :word_camps, :start
  end
end
