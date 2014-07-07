class UsersController < ApplicationController  
  def new
    @user = User.new 
  end

  def show
  	@user = User.find_by name: (params[:name])
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
end