class Admin::UserOrdersController < Admin::BaseController
  def index
    users = User.where(id: params[:id])
    if users.empty?
      render_404
    else
      @orders = users.first.orders
    end
  end

  def show
    users = User.where(id: params[:user_id])
    if users.empty?
      render_404
    else
      orders = users.first.orders.where(id: params[:order_id])
      if orders.empty?
        render_404
      else
        @order = orders.first
      end
    end
  end
end
