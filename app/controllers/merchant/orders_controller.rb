class Merchant::OrdersController < Merchant::BaseController
  def show
    @merchant = current_user.merchant
    orders = Order.where(id: params[:id])
    if orders.empty?
      render_404
    else
      @order = orders.first
    end
  end
end
