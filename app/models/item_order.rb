class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def unfulfilled?
    status == 'unfulfilled'
  end

  def fulfilled?
    status == 'fulfilled'
  end

  def cancelled?
    status == 'cancelled'
  end

  def enough_inventory?
    quantity <= item.inventory
  end
end
