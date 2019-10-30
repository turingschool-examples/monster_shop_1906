class OrdersController <ApplicationController

  def new

  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create(user_id: current_user.id)
    if cart.contents.any? && order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:success] = ['Your order has been successfully created!']
      redirect_to '/profile/orders'
    else
      flash[:error] = ["Please add something to your cart to place an order"]
      redirect_to '/items'
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
