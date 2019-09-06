require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zipcode}
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}

    it {should validate_confirmation_of(:password).on(:create)}

    it {should validate_uniqueness_of(:email).case_insensitive}
    it {should allow_value('user@example.com').for(:email)}
    it {should_not allow_value("foo").for(:email)}
  end
end
