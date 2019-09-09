class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = 'You are now a registered user and have been logged in.'
      login_redirection
    else
      flash[:error] =  @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
   @user = current_user
   if @user.update(updated_profile_params)
       flash[:notice] = 'Your profile has been updated!'
       redirect_to '/profile'
   else
     flash[:error]= @user.errors.full_messages
     redirect_to '/profile/edit'
   end
 end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def updated_profile_params
    params.require(:user).permit(:name, :address, :city, :state, :email, :zip)
  end

