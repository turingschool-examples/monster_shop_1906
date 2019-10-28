require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :email}
    it { should validate_uniqueness_of :email}

    it { should validate_numericality_of(:zip).only_integer }
    it { should validate_length_of(:zip).is_equal_to(5) }
  end

  describe 'relationships' do
    it { should have_many :orders}
  end

  describe 'roles' do
    it 'can be created as a default user' do
      user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123")

      expect(user.role).to eq('default')
      expect(user.default?).to eq(true)
    end

    it 'can be created as a merchant employee' do
      user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123", role: 1)

      expect(user.role).to eq('merchant_employee')
      expect(user.merchant_employee?).to eq(true)
    end

    it 'can be created as a merchant admin' do
      user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123", role: 2)

      expect(user.role).to eq('merchant_admin')
      expect(user.merchant_admin?).to eq(true)
    end

    it 'can be created as an admin' do
      user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123", role: 3)

      expect(user.role).to eq('admin')
      expect(user.admin?).to eq(true)
    end
  end
end
