class UserOrdersController < ApplicationController
  before_action :require_user

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(status: 3)
    order.item_orders.each do |item_order|
      item_order.update(status: 'cancelled')
    end
    flash[:success] = ['Your order is now cancelled']
    redirect_to '/profile'
  end


  private

  def require_user
    render_404 unless current_user
  end
end
