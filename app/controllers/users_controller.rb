class UsersController<ApplicationController

  def new
  end

  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    flash[:success] = "Welcome #{user.name}! You are now registered and logged in."
    redirect_to "/profile"
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zipcode, :email, :password)
  end
end
