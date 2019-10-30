class Admin::UserOrdersController < Admin::BaseController
  def index
    users = User.where(id: params[:id])
    if users.empty?
      render_404
    else
      @orders = users.first.orders
    end
  end
end
