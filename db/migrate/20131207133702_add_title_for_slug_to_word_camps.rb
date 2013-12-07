class AddTitleForSlugToWordCamps < ActiveRecord::Migration
  def change
    add_column :word_camps, :title_for_slug, :string

    add_index :word_camps, :title_for_slug
  end

  def migrate direction
    super

    if direction == :up
      WordCamp.reset_column_information

      ActiveRecord::Base.transaction do
        WordCamp.all.each do |wordcamp|
          wordcamp.title_for_slug = wordcamp.title.downcase.gsub(/\s*wordcamp\s*/, '').gsub(/[^a-z0-9]+/, '_')

          wordcamp.save
        end
      end
    end
  end
end
