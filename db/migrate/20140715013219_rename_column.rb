class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :favorites, :user, :user_id
  end
end
