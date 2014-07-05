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

  def fetchRandomEntry #horribly innefficient, will have to come up with something better
  	offset = rand(GifEntry.count)
  	allRecords = GifEntry.all
  	rand_record = allRecords[offset]
 		render plain: rand_record.url #for now only fetch url
  end

  def showImage
  end


end
