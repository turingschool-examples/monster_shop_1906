class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :current_employee?, :current_merchant?, :current_admin?

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_employee?
    current_user && current_user.employee?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def current_admin?
    current_user && current_user.admin?
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
