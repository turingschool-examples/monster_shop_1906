class User <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates :e_mail, uniqueness: true, presence: true

  validates :password, :presence =>true, :confirmation =>true
  validates_confirmation_of :password

  has_secure_password

  enum role: %w(default merchant_employee merchant_admin admin)

end
