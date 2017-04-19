class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # NOTE: ?? do we want a user show eventuall ???
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
end
