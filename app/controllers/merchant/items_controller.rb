class Merchant::ItemsController < Merchant::BaseController
  def index
    # binding.pry
    @items = current_user.merchant.items
  end
  #
  # def show
  #   @user = User.find(params[:id])
  # end
end
