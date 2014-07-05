class GifEntriesController < ApplicationController
	
	def index
	end

	def new
		@entry = GifEntry.new
	end

	def create
		@entry = GifEntry.new(params.require(:gifentry).permit([:score, :url]))
    @entry.save
    redirect_to gifentry_path
  end

  
end
