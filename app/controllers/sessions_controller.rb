class SessionsController < ApplicationController
	def login
	end

	def home
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


end
