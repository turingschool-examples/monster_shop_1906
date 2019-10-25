class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :password_confirmation, require: true
  has_secure_password

  enum role: %w(default merchant_employee merchant_admin admin)
end


# validates :password,
#           presence: true,
#           length: { minimum: 2 },
#           confirmation: { case_sensitive: true },
#           if: :password
#
# validates :password_confirmation,
#           presence: true,
#           if: :password
