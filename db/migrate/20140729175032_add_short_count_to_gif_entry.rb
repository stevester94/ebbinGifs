class AddShortCountToGifEntry < ActiveRecord::Migration
  def change
    add_column :gif_entries, :shortCount, :integer
  end
end
