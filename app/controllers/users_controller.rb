class UsersController < ApplicationController

  def new
  end

  def create
    user = User.create!(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to '/profile'
    end
  end

  def show
  end

  def login
  end

private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
