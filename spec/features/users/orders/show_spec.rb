require 'rails_helper'

describe "as a register user" do
  describe "when I visit one of my order show pages (/profile/orders/order_id)" do
    it "sees all information about the order" do

      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      user = User.create(name: 'Bob J', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'user@user.com', password: 'password' )

      order_1 = user.orders.create!(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      item_order_2 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/profile/orders'

      click_link "Order #: #{order_1.id}"

      expect(current_path).to eq("/profile/orders/#{order_1.id}")

      within ".shipping-address" do
        expect(page).to have_content(order_1.id)
      end

      within "#grandtotal" do
        expect(page).to have_content(order_1.grandtotal)
        expect(page).to have_content(order_1.item_count)
      end

      within "#status" do
        expect(page).to have_content(order_1.status.capitalize)
      end

      within "#datecreated" do
        expect(page).to have_content(order_1.created_date)
        expect(page).to have_content(order_1.updated_date)
      end

      within "#item-#{tire.id}" do
        expect(page).to have_content(tire.name)
        expect(page).to have_content(tire.description)
        expect(page).to have_css("img[src*='#{tire.image}']")
        expect(page).to have_content("2")
        expect(page).to have_content("$100.00")
        expect(page).to have_content("$200.00")
      end

      within "#item-#{chain.id}" do
        expect(page).to have_content(chain.name)
        expect(page).to have_content(chain.description)
        expect(page).to have_css("img[src*='#{chain.image}']")
        expect(page).to have_content("1")
        expect(page).to have_content("$50.00")
        expect(page).to have_content("$50.00")
      end
    end
  end
end