# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}! You are now logged in and registered."
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.uniq.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(update_profile_params)
      flash[:success] = 'Your profile data has been updated!'
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.uniq.to_sentence
      render :edit
    end
  end

  def show
    render_404 unless current_user
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end

  def update_profile_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end
end
