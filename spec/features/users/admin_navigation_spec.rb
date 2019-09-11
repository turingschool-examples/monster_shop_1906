# User Story 5, Admin Navigation
#
# As an admin user
# I see the same links as a regular user
# Plus the following links
# - a link to my admin dashboard ("/admin")
# - a link to see all users ("/admin/users")
#
# Minus the following links/info
# - a link to my shopping cart ("/cart") or count of cart items

require 'rails_helper'

RSpec.describe 'Admin Navigation' do
  describe 'As a admin user' do
    it 'I see the same links as a regular user plus link to my asmin
    dashboard and a link to see all users, but not a cart link nor cart counter' do
      user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", role:3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      expect(page).to have_link("Dashboard")
      expect(page).to have_link("Users")
      expect(page).to_not have_link("Cart")
    end
  end

    describe "see all orders" do
      before :each do
        @user = User.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'Colorado', zip: '80205', email: 'StarPerfect@gmail.com', password: 'Hello123')
        visit login_path

        fill_in :email, with: @user.email
        fill_in :password, with: @user.password

        click_button 'Login'

        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
        @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        @order_1 = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id, status: 1)
        @order_2 = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id, status: 2)
        @order_3 = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id, status: 0)
        @item_order_1 = @order_1.item_orders.create(item: @tire, price: @tire.price, quantity: 2)
        @item_order_2 = @order_2.item_orders.create(item: @paper, price: @paper.price, quantity: 20)
        @item_order_3 = @order_3.item_orders.create(item: @pencil, price: @pencil.price, quantity: 5)
        @item_order_4 = @order_2.item_orders.create(item: @pencil, price: @pencil.price, quantity: 1)
      end


    it "shows me all orders in the system whith order id
    and links to the user " do
      @kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesome@gmail.com", password: "ours", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@kate)

      visit "/admin"

      expect(page).to have_link("Profile")

      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_2.id)
      expect(page).to have_content(@order_3.id)

      expect(page).to have_content(@order_1.created_at)
      expect(page).to have_content(@order_2.created_at)
      expect(page).to have_content(@order_3.created_at)

      expect(page).to have_link(@order_1.name)
      expect(page).to have_link(@order_2.name)
      expect(page).to have_link(@order_3.name)

      expect(page).to have_content(@order_1.status)
      expect(page).to have_content(@order_2.status)
      expect(page).to have_content(@order_3.status)

      within "#order-#{@order_1.id}" do
        click_on @order_1.name
        expect(current_path).to eq(admin_user_show_path(@user))
      end
    end

    it "can ship an order" do
        user = User.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'Colorado', zip: '80205', email: 'Star@gmail.com', password: 'Hello123')
        visit login_path

        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_button 'Login'

        mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
        pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        order_1 = Order.create(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id, status: 1)
        order_2 = Order.create(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id, status: 2)
        order_3 = Order.create(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id, status: 1)
        item_order_1 = order_1.item_orders.create(item: tire, price: tire.price, quantity: 2)
        item_order_2 = order_2.item_orders.create(item: paper, price: paper.price, quantity: 20)
        item_order_3 = order_3.item_orders.create(item: pencil, price: pencil.price, quantity: 5)
        item_order_4 = order_2.item_orders.create(item: pencil, price: pencil.price, quantity: 1)

        kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesomegmail.com", password: "ours", role: 3)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(kate)

        visit "/admin"

        within "#order-#{order_1.id}" do
          click_on "Ship Order"

          expect(current_path).to eq("/admin")

          expect(page).to have_content("shipped")
      end
    end
  end
end
