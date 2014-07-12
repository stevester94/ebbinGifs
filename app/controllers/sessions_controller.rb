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
    if authorized_user.is_a? String #atrocious, model returns error as string, or user on success
      flash[:message] = authorized_user
      render "login"
    else
      session[:name] = authorized_user.name
      redirect_to root_path
    end
  end
	
end
