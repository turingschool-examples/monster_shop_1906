class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = 'You are now a registered user and have been logged in.'
      redirect_to profile_path(@user)
    else
      # flash[error] =  @user.errors.full_messages
      render :new
    end
  end

  def show
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end
