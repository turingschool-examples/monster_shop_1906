class User < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :email

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password
  has_many :orders

  enum role: %w(default employee merchant admin)
end
