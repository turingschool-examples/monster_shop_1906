class UsersController < ApplicationController

  def new
  end

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.name}!"
    redirect_to "/profile"
  end

  def show
  end


private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
