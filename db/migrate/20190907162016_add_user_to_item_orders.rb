class AddUserToItemOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :item_orders, :user, foreign_key: true
  end
end
