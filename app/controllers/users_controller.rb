class UsersController < ApplicationController  
  GIFS_PER_PAGE = 12

  def new
    @user = User.new 
  end

  def show
    user_id = params[:param_id]
    @pageNumber = params[:page].to_i
  	@user = User.find(user_id)
  	@favorites = @user.favorites.sort_by(&:created_at)

    @pageCount = @favorites.count / GIFS_PER_PAGE
    beginIndex = @pageNumber * GIFS_PER_PAGE
    endIndex = beginIndex + GIFS_PER_PAGE - 1
    @favorites = @favorites[beginIndex..endIndex]
  end

  def create
    @user = User.new(params.require(:user).permit([:name, :password, :password_confirmation]))
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Left Arrow: downvote, Right Arrow: upvote, Up Arrow: favorite, WASD also supported"
      redirect_to root_path
    else
      allMessages = ""
      for message in @user.errors.full_messages
        allMessages = allMessages + " " + message
      end
      flash[:message] = allMessages
      redirect_to "/users/new"
    end
  end

	def addFavorite
		render nothing: true
		user = User.find(session[:user_id])
		user.favorites.create(url: params[:url])
	end

	def deleteFavorite 
		render nothing: true
		Favorite.where(:id => params[:id]).destroy_all
	end

end