class Admin::MerchantsController < Admin::BaseController
  def update
    merchant = Merchant.find(params[:id])
    merchant.toggle! :enabled?
    # merchant.items.each do |item|
    #   item.toggle! :active?
    # end
    if merchant.enabled?
      merchant.items.each do |item|
        item.update(active?: true)
      end
        flash[:success] = ["#{merchant.name} has been enabled"]
    else
      merchant.items.each do |item|
        item.update(active?: false)
      end
      flash[:success] = ["#{merchant.name} has been disabled"]
    end
    redirect_to '/merchants'
  end
end
