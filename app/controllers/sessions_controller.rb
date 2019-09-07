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
    session.delete(:user_id)
    current_user = nil
    flash[:notice] = "You have been logged out!"
    redirect_to login_path
  end

  private

  def login_redirection
    if current_admin?
      redirect_to admin_dashboard_path
    elsif current_employee?
      redirect_to employee_dashboard_path
    elsif current_merchant?
      redirect_to merchant_dashboard_path
    else current_user
      redirect_to profile_path
    end
  end
end
