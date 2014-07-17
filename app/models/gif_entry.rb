class GifEntry < ActiveRecord::Base
  has_many :connections, foreign_key: "origin_id"
  has_many :back_connections, foreign_key: "destination_id"

	def self.randomEntry
  	offset = rand(self.count)
  	allRecords = self.all
  	rand_record = allRecords[offset]
  	return rand_record
  end

  def self.updateScore(url, score)
  	selectedRec = self.find_by url: url
  	selectedRec.score = selectedRec.score + score.to_i
  	selectedRec.save
  end

end
