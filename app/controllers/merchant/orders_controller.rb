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

  def update
    item_order = ItemOrder.find(params[:item_order_id])
    item_order.update(status: 'fulfilled')

    item = Item.find(item_order.item_id)
    item.reduce_quantity(item_order.quantity)
    item.save

    flash[:success] = ["You have successfully fulfilled #{item.name} for Order ##{item_order.order_id}"]
    redirect_to "/merchant/orders/#{item_order.order_id}"
  end
end
