class CreateGifEntries < ActiveRecord::Migration
  def change
    create_table :gif_entries do |t|
      t.integer :score
      t.string :url

      t.timestamps
    end
  end
end
