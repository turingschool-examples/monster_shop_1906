class OrdersController <ApplicationController

  def new

  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    user = current_user
    order = user.orders.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      flash[:notice] = "Your order has been created"
      session.delete(:cart)
      redirect_to "/profile/orders"

    end
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
