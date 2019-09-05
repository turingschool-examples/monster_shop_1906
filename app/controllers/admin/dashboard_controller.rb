class Admin::DashboardController < Admin::BaseController
  def index
    @admin_user = User.find(session[:user_id])
  end
end
