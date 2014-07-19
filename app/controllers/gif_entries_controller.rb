class GifEntriesController < ApplicationController


	def index
		@entries = GifEntry.all
	end

	def new
		@entry = GifEntry.new
	end

  def autoCreate
    render :nothing => true
    @entry = GifEntry.new(score: 0, url: params[:param_url])
    @entry.save
    GifEntry.all.each do |record| #create a connection to all existing GifEntries
      if !(@entry.id == record.id)
        @entry.connections.create(strength: 0, destination_id: record.id)
        record.connections.create(strength: 0, destination_id: @entry.id)
      end
    end
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
    #GifEntry.suggestedEntry will contain all of the logic for selecting the next gif

    currentEntry = GifEntry.find_by(url: params[:current_url])
    pastEntry = GifEntry.find_by(url: params[:past_url])

    if currentEntry != nil
      entry = currentEntry.suggestedEntry(params[:vote])
    else
      entry = GifEntry.randomEntry
    end
    render plain: entry.to_json

  	if currentEntry != nil
      currentEntry.updateScore(params[:vote])
      if pastEntry != nil
        pastEntry.updateConnection(currentEntry, params[:vote])
      end
	  end
  end

  def showImage
  end

  private



end
