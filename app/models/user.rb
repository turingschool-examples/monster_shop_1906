class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  has_secure_password
  has_many :orders

  enum role: %w(default merchant_employee merchant_admin admin)
end
