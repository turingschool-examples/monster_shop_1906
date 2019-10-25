class Profile::OrdersController < ApplicationController

  def index

  end

  def create
    if current_user
      order = Order.create(order_params)
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:success] = 'Thank you for placing your order'
      redirect_to "/profile/orders"
    else
      flash[:error] = 'Please login or register to continue'
      redirect_to '/cart'
    end
  end


  private

  def order_params
    {user_id: current_user.id, name: current_user.name, address: current_user.address, city: current_user.city, state: current_user.state, zip: current_user.zip}
  end
end
