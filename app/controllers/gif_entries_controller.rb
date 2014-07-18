class GifEntriesController < ApplicationController


	def index
		@entries = GifEntry.all
	end

	def new
		@entry = GifEntry.new
	end

	def create
		@entry = GifEntry.new(params.require(:gif_entry).permit([:score, :url]))
    @entry.save
    GifEntry.all.each do |record| #create a connection to all existing GifEntries
      if !(@entry.id == record.id)
        @entry.connections.create(strength: 0, destination_id: record.id)
        record.connections.create(strength: 0, destination_id: @entry.id)
      end
    end
    redirect_to root_path
  end

  def fetchEntry 
    randomEntry = GifEntry.randomEntry
    render plain: randomEntry.to_json

    currentEntry = GifEntry.find_by(url: params[:current_url])
    pastEntry = GifEntry.find_by(url: params[:past_url])

  	if params[:current_url] != 'null'
      currentEntry.updateScore(params[:vote])
      pastEntry.updateConnection(currentEntry, params[:vote])
	  end
  end

  def showImage
  end

  private



end
