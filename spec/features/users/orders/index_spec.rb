require 'rails_helper'

describe 'When I visit a Profile Orders page (eg profile/orders#index), /profile/orders' do
  describe 'as a registered user' do
    it 'shows every order a user has made with specific information' do

      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      user = User.create(name: 'Bob J', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'user@user.com', password: 'password' )

      order_1 = user.orders.create!(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      item_order_2 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 1)

      order_2 = user.orders.create!(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id)
      item_order_1 = order_2.item_orders.create!(item: tire, price: tire.price, quantity: 3)
      item_order_2 = order_2.item_orders.create!(item: chain, price: chain.price, quantity: 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/profile/orders'

      within "#order-#{order_1.id}" do
        expect(page).to have_link("Order #: #{order_1.id}")
        expect(page).to have_content("Date of Order: #{order_1.created_date}")
        expect(page).to have_content("Last Updated: #{order_1.updated_date}")
        expect(page).to have_content("Order Status: #{order_1.status.capitalize}")
        expect(page).to have_content("Item Total: #{order_1.item_count}")
        expect(page).to have_content("Grand Total: #{order_1.grandtotal}")
      end

      within "#order-#{order_2.id}" do
        expect(page).to have_link("Order #: #{order_2.id}")
        expect(page).to have_content("Date of Order: #{order_2.created_date}")
        expect(page).to have_content("Last Updated: #{order_2.updated_date}")
        expect(page).to have_content("Order Status: #{order_2.status.capitalize}")
        expect(page).to have_content("Item Total: #{order_2.item_count}")
        expect(page).to have_content("Grand Total: #{order_2.grandtotal}")
      end
    end
  end
end
