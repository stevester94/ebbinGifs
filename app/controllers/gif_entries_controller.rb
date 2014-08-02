class GifEntriesController < ApplicationController


	def index
		@entries = GifEntry.all
	end

	def new
    if session[:user] != 'hamster40'
      redirect_to root_path
    end
    
		@entry = GifEntry.new
	end

  def autoCreate
    render :nothing => true
    #shortCount initialized so caches will be generated
    p $AUTO_CREATE_KEY
    if params[:key] == $AUTO_CREATE_KEY
      @entry = GifEntry.new(score: 0, url: params[:param_url], shortCount: 11) 
      @entry.save
      GifEntry.all.each do |record| #create a connection to all existing GifEntries
        if !(@entry.id == record.id)
          @entry.connections.create(strength: 0, destination_id: record.id)
          record.connections.create(strength: 0, destination_id: @entry.id)
        end
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

    if session[:user_id] != nil
      if User.find(session[:user_id]).favorites.exists?(:url => entry.url)
        favorited = true
      else
        favorited = false
      end
    else
      favorited = false
    end


    response = {:url => entry.url, :score => entry.score, :favorited => favorited}
    render plain: response.to_json

  	if currentEntry != nil
      currentEntry.updateScore(params[:vote])
      if pastEntry != nil
        pastEntry.updateConnection(currentEntry, params[:vote])
      end
	  end
  end

  def showImage
  end

  def autoVote
  end

  private



end
