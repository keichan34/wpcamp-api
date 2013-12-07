class AddDescriptionToWordCamps < ActiveRecord::Migration
  def change
    add_column :word_camps, :description, :text
  end

  def migrate direction
    super

    if direction == :up
      execute "CREATE INDEX ft_description_on_word_camps ON word_camps USING gin(to_tsvector('english', description));"
      execute "CREATE INDEX ft_title_on_word_camps ON word_camps USING gin(to_tsvector('english', title));"
    elsif direction == :down
      execute "DROP INDEX ft_title_on_word_camps;"
    end
  end
end
