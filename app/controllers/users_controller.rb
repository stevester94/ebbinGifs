class UsersController < ApplicationController  
  def new
    @user = User.new 
  end

  def show
    user = session[:name]
    @loggedIn = params[:name] == session[:name] #if profile being viewed is own account
  	@user = User.find_by_name(params[:name])
  	@favorites = Favorite.where(:user => params[:name])

  end

  def create
    @user = User.new(params.require(:user).permit([:name, :password, :password_confirmation]))
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render "new"
  end

	def addFavorite
		render nothing: true
		h = Hash.new()
		h["user"] = session[:name]
		h["url"] = params[:url]
		@entry = Favorite.new(h)
		@entry.save
	end

	def deleteFavorite #deleted based on id, was a workaround for confusing string handling
		render nothing: true
		Favorite.where(:id => params[:id]).destroy_all
	end

end