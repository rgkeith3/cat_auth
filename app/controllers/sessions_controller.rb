class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
                                    params[:user][:username],
                                    params[:user][:password]
                                   )
    if @user
      # user.reset_session_token!
      # session[:session_token] = user.session_token
      # user.save
      login_user!
      redirect_to cats_url
    else
      # TODO: figure this out
      flash.now[:error]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

  private

  def redirect_if_logged_in
    if current_user
      redirect_to cats_url
    end
  end
end
