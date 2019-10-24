class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome back, #{user.name}!"
    redirect_login
  end

  def logout
  end

  private
  
  def redirect_login
    if merchant_employee? || merchant_admin?
      redirect_to merchant_dashboard_path
    elsif site_admin?
      redirect_to admin_path
    else
      redirect_to profile_path
    end
  end
end
