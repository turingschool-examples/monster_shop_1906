class Users::OrdersController < ApplicationController

  def index
    @user = current_user
    @orders = @user.orders
  end

  def create
    user = current_user
    order = user.orders.create(order_params)
    # binding.pry
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


  def order_params
    {name: current_user.name, address: current_user.address, city: current_user.city, state: current_user.state, zip: current_user.zip}
  end

end
