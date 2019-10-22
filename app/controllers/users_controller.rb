class UsersController < ApplicationController

  def new
  end

  def show
    if !current_user
      render file: '/public/404'
    else
      @user = User.find(session[:user_id])
    end
  end

  def create
    new_user = User.create(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "You are now registered and logged in."
      redirect_to '/profile'
    else
      flash.now[:error] = new_user.errors.full_messages.to_sentence
      render :new
    end
  end

  private
    def user_params
      params.permit(:name,:address,:city,:state,:zip,:email,:password,:password_confirmation)
    end
end
