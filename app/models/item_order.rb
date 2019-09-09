class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity, :status
  validates :status, inclusion: {:in => ['pending', 'packaged', 'shipped', 'cancelled']}
  belongs_to :item
  belongs_to :order
  belongs_to :user
  has_many :merchants, through: :item

  def subtotal
    price * quantity
  end

  def self.total_quantity_per_order(order_id)
    where(order_id: order_id).sum(:quantity)
  end

  def self.grandtotal_per_order(order_id)
    find_by(order_id: order_id).order.grandtotal
  end

  def fulfilled?
    self.status == "pending"
  end
end
