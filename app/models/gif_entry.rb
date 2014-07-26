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

  #if vote is positive, will select all connections with a positive strength
  #if vote is negative will select from all connections.
  def suggestedEntry(vote)

    if vote.to_i > 0
      connections = self.connections.where("strength >= 0")
    else
      connections = self.connections
    end 

    strengths = []
    connections.all.each do |connection|
      strengths.append(connection.strength)
    end

    mean = strengths.mean
    sd = strengths.standard_deviation

    randomStrength = RandomGaussian.new(mean, sd).rand
    closestStrength = find_closest(randomStrength, strengths)

    suggestedEntries = self.connections.where(strength: closestStrength)
    rand = rand(suggestedEntries.count)

    return suggestedEntries[rand].destination
  end

  private
  def find_closest(value, array)
    #if multiple values are found to have the same distance, will be added to an array and 
    # => randomly selected from
    minDistance = (array.first - value).abs
    closestValue = array.first
    array.each do |cur_value|
      if (cur_value - value).abs < minDistance
        minDistance = (cur_value - value).abs
        closestValue = cur_value
      end
    end
    return closestValue
  end

end

class RandomGaussian
  def initialize(mean, stddev, rand_helper = lambda { Kernel.rand })
    @rand_helper = rand_helper
    @mean = mean
    @stddev = stddev
    @valid = false
    @next = 0
  end

  def rand
    if @valid then
      @valid = false
      return @next
    else
      @valid = true
      x, y = self.class.gaussian(@mean, @stddev, @rand_helper)
      @next = y
      return x
    end
  end

  private
  def self.gaussian(mean, stddev, rand)
    theta = 2 * Math::PI * rand.call
    rho = Math.sqrt(-2 * Math.log(1 - rand.call))
    scale = stddev * rho
    x = mean + scale * Math.cos(theta)
    y = mean + scale * Math.sin(theta)
    return x, y
  end
end