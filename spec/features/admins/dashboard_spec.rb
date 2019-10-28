require 'rails_helper'

RSpec.describe 'Admin dashboard page', type: :feature do
  before :each do
    @user_1 = User.create!(name: "Andy Dwyer", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password", password_confirmation: "password")
    @user_2 = User.create!(name: "April Ludgate", address: "456 Jefferson Ave", city: "Orlando", state: "FL", zip: 32810, email: "test@hotmail.com", password: "password", password_confirmation: "password")
    @admin = User.create!(name: "Ron Swanson", address: "789 Washington Blvd", city: "New Orleans", state: "LA", zip: 70010, email: "test@aol.com", password: "password", password_confirmation: "password", role: 3)

    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 4)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    @order_1 = Order.create!(user_id: @user_1.id)
    @order_2 = Order.create!(user_id: @user_2.id, status: 0)
    @order_1.item_orders.create!(item_id: @tire.id, price: @tire.price, quantity: 1)
    @order_1.item_orders.create!(item_id: @paper.id, price: @paper.price, quantity: 2)
    @order_2.item_orders.create!(item_id: @tire.id, price: @tire.price, quantity: 3)
    @order_2.item_orders.create!(item_id: @pencil.id, price: @pencil.price, quantity: 4)
    @order_2.item_orders.create!(item_id: @paper.id, price: @paper.price, quantity: 1)

    visit '/login'

    fill_in :email, with: 'test@aol.com'
    fill_in :password, with: 'password'

    click_button 'Login'

    visit '/admin'
  end

  it 'can show all orders' do
    within "#order-#{@order_1.id}" do
      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(@order_1.status)
      expect(page).to have_link(@user_1.name)
    end

    within "#order-#{@order_2.id}" do
      expect(page).to have_content(@order_2.id)
      expect(page).to have_content(@order_2.created_at.strftime("%m/%d/%Y"))
      expect(page).to have_content(@order_2.status)
      expect(page).to have_link(@user_2.name)
    end
  end

  xit 'shows links to user profile who placed order' do
    click_link "#{@user_1.name}"

    expect(current_path).to eq("/admin/users/#{@user_1.id}")
  end

  xit 'sorts orders by status' do
    # how to test order of items on page?
  end
end


# User Story 30, Admin can see all orders
#
# As an admin user
# When I visit my admin dashboard ("/admin")
# Then I see all orders in the system.
# For each order I see the following information:
#
# - user who placed the order, which links to admin view of user profile
# - order id
# - date the order was created
#
# Orders are sorted by "status" in this order:
#
# - packaged
# - pending
# - shipped
# - cancelled
