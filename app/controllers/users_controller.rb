class UsersController<ApplicationController

  def new
  end

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    flash[:success] = "Welcome #{user.name}! You are now registered and logged in."
    redirect_to "/profile"
  end

  def show
    @user = current_user
    render :profile
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)

    if @user.save
      flash[:sucess] = "Your profile has been updated"
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to "/profile/edit"
    end
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zipcode, :email, :password, :password_confirmation)
  end
end
