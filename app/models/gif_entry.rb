class GifEntry < ActiveRecord::Base
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
