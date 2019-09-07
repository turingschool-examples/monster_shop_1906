class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant_user = current_user
    @merchant = @merchant_user.merchant
  end
end
