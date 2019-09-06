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

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

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
