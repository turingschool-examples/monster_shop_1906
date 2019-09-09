class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant_user = current_user
    @merchant = @merchant_user.merchant
    @pending_orders = @merchant.pending_orders
  end
end
