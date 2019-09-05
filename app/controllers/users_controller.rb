class UsersController<ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}! You are now registered and logged in."
      redirect_to "/profile"
    else
      flash[:error] = user.errors.full_messages.uniq.to_sentence
      redirect_to "/register"
    end
  end

  def show
    @user = User.find(session[:user_id])
    render :profile
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
  end
end
