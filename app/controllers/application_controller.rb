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
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
