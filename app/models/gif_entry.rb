class GifEntry < ActiveRecord::Base
  has_many :connections, foreign_key: "origin_id"
  has_many :back_connections, foreign_key: "destination_id"

	def self.randomEntry
  	offset = rand(self.count)
  	allRecords = self.all
  	rand_record = allRecords[offset]
  	return rand_record
  end

  def updateScore(vote)
    self.score = self.score + vote.to_i
    self.save
  end

  def updateConnection(destinationRecord, vote)
    if self.id != destinationRecord.id
      connection = self.connections.find_by(destination_id: destinationRecord.id)
      connection.strength = connection.strength + vote.to_i
      connection.save
    end
  end

  def suggestedEntry 
    #currently selects the strongest connection, proof of concept. works

    connections = self.connections.order('strength DESC')
    connection  = connections.first
    return connection.destination
  end

  # def self.updateScore(url, score)
  # 	selectedRec = self.find_by url: url
  # 	selectedRec.score = selectedRec.score + score.to_i
  # 	selectedRec.save
  # end

end
