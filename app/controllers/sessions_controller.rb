class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(e_mail: params[:e_mail])
    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"

      redirect_to '/profile'
    else
      flash[:error] = 'Credentials were incorrect.'
      redirect_to '/login'
    end
  end

end
