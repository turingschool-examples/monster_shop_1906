class Merchant::OrdersController < Merchant::BaseController
  def show
    order = Order.find(params[:id])
    @item_orders = current_user.merchant.item_orders.where(order: order.id)
  end
end
