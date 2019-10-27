require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :items}
  end

  describe 'instance methods' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 30, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      @user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123")
      @user_1 = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Hershey", state: "CO", zip: 23840, email: "test1@gmail.com", password: "password123", password_confirmation: "password123")
    end
    it 'no_orders' do
      expect(@meg.no_orders?).to eq(true)

      order_1 = Order.create!(user_id: @user.id)
      order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.no_orders?).to eq(false)
    end

    it 'item_count' do
      expect(@meg.item_count).to eq(2)
    end

    it 'average_item_price' do
      expect(@meg.average_item_price).to eq(65)
    end

    it 'distinct_cities' do
      order_1 = Order.create!(user_id: @user.id)
      order_2 = Order.create!(user_id: @user_1.id)
      order_3 = Order.create!(user_id: @user.id)
      order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      order_2.item_orders.create!(item: @chain, price: @chain.price, quantity: 2)
      order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.distinct_cities).to eq(['Denver', 'Hershey']).or eq(['Hershey', 'Denver'])
    end

  end
end
