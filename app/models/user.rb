class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email

  validates :email, uniqueness: true
  validates :password,
            presence: true,
            length: { minimum: 2 },
            confirmation: { case_sensitive: true },
            :if => :password

  has_many :orders
  has_many :merchant_users
  has_many :merchants, through: :merchant_users

  has_secure_password

  enum role: [:default, :merchant_employee, :merchant_admin, :admin]

  def has_orders?
    orders.count > 0
  end
end
