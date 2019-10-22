class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email
  validates :email, uniqueness: true
  validates :password, presence: true, confirmation: { case_sensitive: true }
  has_secure_password

  enum role: [:default]
end
