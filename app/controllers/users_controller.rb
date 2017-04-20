class UsersController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # NOTE: ?? do we want a user show eventuall ???
      login_user!
      redirect_to cats_url
    else
      flash[:error] = "Missing required form stuff"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def redirect_if_logged_in
    if current_user
      redirect_to cats_url
    end
  end
end
