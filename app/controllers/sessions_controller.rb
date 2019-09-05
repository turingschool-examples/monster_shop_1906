class SessionsController<ApplicationController

  def new
    render "users/login"
  end

  def create
    user = User.find_by(email: params[:email])
    flash[:success] = "Logged in as #{user.name}"
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin_user?
        redirect_to "/admin"
      elsif user.merchant_admin?
        redirect_to "/merchant"
      else
        redirect_to "/profile"
      end
    else
      render "users/login"
      flash[:error] = "You have entered incorrect login information"
    end
  end
end
