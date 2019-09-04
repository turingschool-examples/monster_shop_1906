class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :address, :city, :state, :zipcode, :password_digest, :password_confirmation
  validates :email, uniqueness: true, presence: true
end
