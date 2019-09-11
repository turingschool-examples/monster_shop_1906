class Admin::DashboardController < ApplicationController

  def show
    @orders = Order.sorted
  end

  def user_show
    # @user = User.find(params[:user_id])
  end

  def ship
    order = Order.find(params[:format])
    x = order.update(status: 2)
    redirect_to "/admin"
  end

end
