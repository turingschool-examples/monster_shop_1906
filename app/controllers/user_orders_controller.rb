class UserOrdersController < ApplicationController
  before_action :require_user

  def index
    @orders = current_user.orders
  end

  def show
    orders = current_user.orders.where(id: params[:id])
    if orders.empty?
      render_404
    else
      @order = orders.first
    end
  end

  def update
    order = Order.find(params[:id])
    order.update(status: 3)
    order.item_orders.each do |item_order|
      if item_order.fulfilled?
        item = item_order.item
        item.increase_inventory(item_order.quantity)
        item.save
      end
      item_order.update(status: 2)
    end
    flash[:success] = ['Your order is now cancelled']
    redirect_to '/profile'
  end


  private

  def require_user
    render_404 unless current_user
  end
end
