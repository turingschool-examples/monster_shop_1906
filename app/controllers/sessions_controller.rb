class SessionsController < ApplicationController

  def new
    if current_admin?
      flash[:notice] = 'You are already logged in.'
      redirect_to "/admin/#{current_user.id}"
    elsif current_merchant?
      flash[:notice] = 'You are already logged in.'
      redirect_to "/merchant/#{current_user.id}"
    elsif current_user
      flash[:notice] = 'You are already logged in.'
      redirect_to "/profile/#{current_user.id}"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}! You are logged in."
      if user.role == "default"
        redirect_to "/profile/#{user.id}"
      elsif user.role == "merchant_employee" || user.role == "merchant_admin"
        redirect_to "/merchant/#{user.id}"
      elsif user.role == "admin"
        redirect_to "/admin/#{user.id}"
      end
    else
      flash[:error] = 'Credentials were incorrect.'
      redirect_to '/login'
    end
  end


  def destroy
    session.delete :user_id
    session.delete :cart
    @current_user = nil
    flash[:success] = "You have been logged out."

    redirect_to '/'
  end
end
