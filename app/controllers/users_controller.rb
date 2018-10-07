class UsersController < ApplicationController

	before_filter :save_login_state, only: [:new, :create]

  def new
    @user = User.new 
  end

  def create
    @user = User.new(ad_params)
    if @user.save
      redirect_to(controller: 'sessions', action: 'login')
    else
      render 'new'
    end
    
  end

  private
  def ad_params    
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
