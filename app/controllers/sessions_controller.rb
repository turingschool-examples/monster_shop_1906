class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      login_redirection
    else
      flash[:error] = 'Invalid Credentials, please try again.'
      render :new
    end
  end

  def destroy
    session.delete(:cart)
    session.delete(:user_id)
    current_user = nil
    flash[:notice] = "You have been logged out!"
    redirect_to login_path
  end
end
