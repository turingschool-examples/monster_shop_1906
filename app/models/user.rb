class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password_digest, require: true
  # validates :password_confirm, presence: true
  validates_length_of :zip, :is => 5
  validates_numericality_of :zip
end
