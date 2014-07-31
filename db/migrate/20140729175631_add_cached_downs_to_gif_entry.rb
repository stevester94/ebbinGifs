class AddCachedDownsToGifEntry < ActiveRecord::Migration
  def change
    add_column :gif_entries, :cachedDowns, :text
  end
end
