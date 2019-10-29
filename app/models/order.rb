class Order <ApplicationRecord
  validates_presence_of :status

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  enum status: %w(Packaged Pending Shipped Cancelled)

  def grandtotal
    item_orders.sum('price * quantity')
  end
end
