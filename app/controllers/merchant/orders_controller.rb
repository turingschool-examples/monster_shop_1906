class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @item_orders = current_user.item_orders_by_merchant(@order.id)
  end
end
