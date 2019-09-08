class MerchantUser < ApplicationRecord
  belongs_to :merchant
  belongs_to :user

  # def merchant_item_orders(order_id)
  #
  # end
end
