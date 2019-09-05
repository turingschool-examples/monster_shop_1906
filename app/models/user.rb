class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zipcode, :password_digest
  validates :email,
            uniqueness: true,
            presence: true
  validates_confirmation_of :password_digest, require: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  enum role: [:regular_user, :merchant_employee, :merchant_admin, :admin_user]
  
  has_secure_password
end
