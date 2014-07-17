#represents a complete and directed graph between all gif entries
class Connection < ActiveRecord::Base
	belongs_to :origin, class_name: 'GifEntry', foreign_key: "origin_id"
  belongs_to :destination, class_name: 'GifEntry',foreign_key: "destination_id"
end
