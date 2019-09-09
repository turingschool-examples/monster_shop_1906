class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = Item.where(merchant_id: current_user.merchant_id)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if item.no_orders?
    flash[:delete_item_warning] = "#{item.name} is now deleted!"
    redirect_to merchant_user_index_path
  end
end
