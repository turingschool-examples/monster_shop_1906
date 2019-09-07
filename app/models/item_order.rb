class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity, :status
  validates :status, inclusion: {:in => ['pending', 'packaged', 'shipped', 'cancelled']}
  belongs_to :item
  belongs_to :order
  belongs_to :user

  def subtotal
    price * quantity
  end

end
