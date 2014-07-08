class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :user
      t.string :url

      t.timestamps
    end
  end
end