class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant_user = current_user
  end
end
