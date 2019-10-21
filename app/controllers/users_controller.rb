class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(session[:user_id])
  end

  def create
    new_user = User.create(user_params)
    session[:user_id] = new_user.id
    flash[:success] = "You are now registered and logged in."
    redirect_to '/profile'
  end

  private
    def user_params
      params.permit(:name,:address,:city,:state,:zip,:email,:password,:password_confirmation)
    end
end
