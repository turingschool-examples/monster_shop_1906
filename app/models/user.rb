class User < ApplicationRecord
  has_secure_password

  validates_presence_of :name, :address, :city, :state, :zipcode, :password_digest
  validates :email, presence: true, 
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: { case_sensitive: false }          
  validates_confirmation_of :password_digest, require: true

  enum role: [:regular_user, :merchant_employee, :merchant_admin, :admin_user]
end
