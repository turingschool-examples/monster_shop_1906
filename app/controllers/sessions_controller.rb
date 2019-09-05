class SessionsController<ApplicationController

  def new
    render "users/login"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.name}!"
      session[:user_id] = user.id
      if user.admin_user?
        redirect_to "/admin"
      elsif user.merchant_admin?
        redirect_to "/merchant"
      else
        redirect_to "/profile"
      end
    else
      flash[:error] = "Please enter valid user information"
      redirect_to "/login"
    end
  end
end
