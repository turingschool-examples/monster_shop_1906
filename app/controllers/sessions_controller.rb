class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Signed in as #{user.name}"
      if current_admin?
        redirect_to '/admin'
      elsif current_merchant_employee? || current_merchant_admin?
        redirect_to '/merchant'
      else
        redirect_to '/profile'
      end
    else
      flash.now[:error] = "Sorry your credentials are bad."
      render :new
    end
  end
end
