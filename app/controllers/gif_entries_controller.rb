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
    redirect_to root_path
  end

  def fetchEntry 
    render plain: GifEntry.randomEntry.to_json

  	if params[:url] != 'null'
      GifEntry.updateScore(params[:url], params[:score])
	  end
  end

  def showImage
  end

end
