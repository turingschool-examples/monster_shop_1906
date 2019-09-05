class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant_user = User.find(session[:user_id])
  end
end
