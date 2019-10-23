class UsersController < ApplicationController

  def verify_user?
    default_user? || current_admin?
  end

  def new
  end

  def show
    if verify_user?
      @user = User.find(params[:user_id])
    else
      render file: "/public/404"
    end
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      session[:user_id] = @new_user.id
      redirect_to "/profile/#{@new_user.id}"
      flash[:sucess] = "You have registered successfully! You are now logged in as #{@new_user.name}."
    else
      flash[:error] = @new_user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    request.env['PATH_INFO'] == "/profile/#{@user.id}/edit/password" ? @password_change = true : @password_change = false
  end

  def update
    @user = User.find(params[:user_id])
    @user.update(user_params)
binding.pry
    if @user.save
      flash[:sucess] = "Hello, #{@user.name}! You have successfully updated your profile." if request.env['REQUEST_METHOD'] == "PUT"
      flash[:sucess] = "Hello, #{@user.name}! You have successfully updated your password." if request.env['REQUEST_METHOD'] == "PATCH"
      redirect_to "/profile/#{@user.id}"
    elsif user_params[:password] && (user_params[:password] != user_params[:password_confirmation])
      flash[:error] = 'Both new passwords must match'
      render :edit
    else
      flash[:error] = "You weren't able to make those changes"
      render :edit
    end
  end

  private

  def user_params
    params.permit(:name, :city, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

end
