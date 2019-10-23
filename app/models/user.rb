class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email

  validates :email, uniqueness: true
  validates :password,
            presence: true,
            confirmation: { case_sensitive: true },
            :if => :password

  has_secure_password

  enum role: [:default, :merchant_employee, :merchant_admin, :admin]
end
