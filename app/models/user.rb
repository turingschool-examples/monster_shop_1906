class User < ApplicationRecord
  has_secure_password

  belongs_to :merchant, optional: true
  # validates_presence_of :merchant, unless: :regular_user?
  # validates_presence_of :merchant, unless: :admin_user?

  validates_presence_of :name, :address, :city, :state, :zipcode, :password
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, confirmation: true

  enum role: [:regular_user, :merchant_employee, :merchant_admin, :admin_user]
end
