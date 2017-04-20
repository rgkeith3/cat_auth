class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
                                    params[:user][:username],
                                    params[:user][:password]
                                   )
    if user
      user.reset_session_token!
      session[:session_token] = user.session_token
      user.save
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

  # private
  #
  # def sessions_params
  #   params.require(:user).permit(:username, :password)
  # end
end
