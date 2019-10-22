require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
  end

  describe 'roles' do
    it "can be created by a default user" do
      user = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'user@user.com',
                          password: 'password',
                          role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end
  end
end