class Admin::DashboardController < ApplicationController

  def show
    @orders = Order.sorted
  end

  def user_show
    # @user = User.find(params[:user_id])
  end

end
