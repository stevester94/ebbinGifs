class UsersController < ApplicationController  
  def new
    @user = User.new 
  end

  def show
    user_id = params[:param_id]
  	@user = User.find(user_id)
  	@favorites = @user.favorites
  end

  def create
    @user = User.new(params.require(:user).permit([:name, :password, :password_confirmation]))
    if @user.save
      session[:user_id] = @user.id
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