class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  has_many :merchants, through: :item

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_items
    item_orders.sum(:quantity)
  end

  def to_s
    "#{self.name} \n
    #{self.address} \n
    #{self.city}, #{self.state} \n
    #{self.zip}
    "
  end

end
