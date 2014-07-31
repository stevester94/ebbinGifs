class AddCachedUpsToGifEntry < ActiveRecord::Migration
  def change
    add_column :gif_entries, :cachedUps, :text
  end
end
