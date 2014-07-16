class SessionsController < ApplicationController
	def login
	end

  def logout
    puts "logout called"
    puts session[:user_id]
    session[:user_id] = "shoop"
    puts session[:user_id]
    redirect_to :root
  end

	def home
    @user = User.find(session[:user_id])
		@favorites = Favorite.where(:user_id => session[:user_id])
	end


	def loginAttempt
    authorized_user = User.authenticate(params[:username], params[:login_password])
    if authorized_user.is_a? String #atrocious, model returns error as string, or user on success
      flash[:message] = authorized_user #this will be an error message
      render "login"
    else
      session[:user_id] = authorized_user.id
      redirect_to root_path
    end
  end
	
end
