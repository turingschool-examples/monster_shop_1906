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

  def pending?
    self.status == "pending"
  end

  def instock?
    self.item.inventory >= self.quantity
  end

  def update_status
    self.update(status: "packaged")
  end

  def self.find_item_orders(order_id, item_order_id)
    where(order: order_id).find(item_order_id)
  end
end
