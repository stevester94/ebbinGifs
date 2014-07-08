class SessionsController < ApplicationController
	def login
	end

	def home
		@favorites = Favorite.where(:user => session[:name])
	end

	def loginAttempt
    authorized_user = User.authenticate(params[:username], params[:login_password])
    if authorized_user
    	puts "succesful login"

      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      session[:name] = authorized_user.name
      redirect_to(:action => 'home')
    else
    	puts "failed login"

      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"	
    end
  end

	def logout
	end

	def addFavorite
		render nothing: true
		h = Hash.new()
		h["user"] = session[:name]
		h["url"] = params[:url]
		@entry = Favorite.new(h)
		@entry.save
	end

	def deleteFavorite
		render nothing: true
		Favorite.where(:user => session[:name]).where(:url => params[:url]).destroy_all
	end


end
