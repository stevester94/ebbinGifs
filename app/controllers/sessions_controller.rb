class SessionsController < ApplicationController
	def login
	end

  def logout
    session[:name] = nil
    redirect_to :root
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
      redirect_to root_path
    else
    	puts "failed login"

      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"	
    end
  end
	
end
