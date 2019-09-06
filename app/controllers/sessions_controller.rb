class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      login_redirection
    else
      flash[:error] = 'Invalid Credentials, please try again.'
      render :new
    end
  end

  private

  def login_redirection
    user = User.find_by(email: params[:email])
    if user.default?
      redirect_to profile_path
    elsif user.employee?
      redirect_to profile_path
    elsif user.merchant?
      redirect_to merchant_dashboard_path
    else user.admin?
      redirect_to admin_dashboard_path
    end
  end
end
