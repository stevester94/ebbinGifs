class ApplicationController < ActionController::Base
	helper :all #expose controller actions to console
  def listConnections	
    allEntries = GifEntry.all

    allEntries.each do |entry|
      puts "id: " + entry.id.to_s
      puts "url: " + entry.url
      entry.connections.each do |connection|
        puts "  origin_id: " + connection.origin_id.to_s
        puts "  destination_id: " + connection.destination_id.to_s
        puts "  strength: " + connection.strength.to_s
      end
    end
  end

  def resetConnectionStrengths
    allConnections = Connection.all
    allConnections.each do |connection|
      connection.strength = 0
      connection.save
    end
  end

  def resetScores
    allEntries = GifEntry.all

    allEntries.each do |entry|
      entry.score = 0
      entry.shortCount = 11
      entry.cachedUps = []
      entry.cachedDowns = []
      entry.save
    end
  end

  def viewCached(id)
    entry = GifEntry.find(id)
    cache = entry.cachedUps
    puts entry.shortCount
    cache.each do |entry|
      print entry
    end
  end

  def resetCaches
    GifEntry.all.each do |entry|
      if entry.shortCount > 10
        next
      end
      entry.calculateCache(1)
      entry.calculateCache(-1)
    end
  end

  def scoreStats
    positive = 0
    negative = 0
    allEntries = GifEntry.all
    allEntries.each do |entry|
      if entry.score > 0
        positive = positive + 1
      else
        negative = negative + 1
      end
    end
    p positive
    p negative

  end


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
