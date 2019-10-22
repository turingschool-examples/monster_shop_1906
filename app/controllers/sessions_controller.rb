class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = ["#{user.name}, you have successfully logged in."]
      redirect_to '/profile'
    else
      flash[:error] = ["Sorry, credentials were invalid. Please try again."]
      render :new
    end
  end
end
