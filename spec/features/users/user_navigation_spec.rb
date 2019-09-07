require 'rails_helper'

RSpec.describe 'User Navigation' do
  describe 'As a registered regular user' do
    it 'I see the same links as a visitor plus a link to my profile and logout' do
      user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", role:0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchants'

      within 'nav' do
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")
      end
    end
  end
end
# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"
RSpec.describe 'Users Order Show Page' do
  describe 'when a logged in user has placed orders' do
    before :each do
      @user = User.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'Colorado', zip: '80205', email: 'StarPerfect@gmail.com', password: 'Hello123')

      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @order_1 = Order.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'CO', zip: '80205')
      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      @order_1 = Order.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'CO', zip: '80205')
      @item_order_2 = @order_2.item_orders.create!(item: @paper, price: @paper.price, quantity: 20)

      @order_3 = Order.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'CO', zip: '80205')
      @item_order_3 = @order_3.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 5)
    end
    it 'can click My Orders profile page link to see all their orders' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
  end
end
