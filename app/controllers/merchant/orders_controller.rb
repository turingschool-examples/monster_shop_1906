class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:id])
    @item_orders = current_user.item_orders_by_merchant(@order.id)

    if @item_orders.empty?
      render file: "/public/404"
    end
  end
end
