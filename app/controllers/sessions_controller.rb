class SessionsController < ApplicationController

    def new
      render 'users/login'
    end

    def login
      render 'users/login'
      
    end

    def create
      user = User.create!(user_params)
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = "Welcome, #{user.name}"
        redirect_to '/profile'
      else
        render 'users/login'
      end
    end
end
