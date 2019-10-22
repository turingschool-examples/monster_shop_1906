class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

<<<<<<< HEAD
  helper_method :cart, :current_user, :current_admin?
=======
  helper_method :cart, :current_user
>>>>>>> f3e4b94bafb0bbb18cee8a96b15aae37adffe39f

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
<<<<<<< HEAD

  def current_admin?
    current_user && current_user.admin?
  end
=======
>>>>>>> f3e4b94bafb0bbb18cee8a96b15aae37adffe39f
end
