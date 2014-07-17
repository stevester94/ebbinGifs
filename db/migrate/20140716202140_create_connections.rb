class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :origin_id
      t.integer :destination_id
      t.integer :strength

      t.timestamps
    end
  end
end
