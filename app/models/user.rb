class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true, if: :password
  validates_presence_of :password_confirmation, require: true, if: :password_confirmation
  has_secure_password

  enum role: %w(default merchant_employee merchant_admin admin)
end
