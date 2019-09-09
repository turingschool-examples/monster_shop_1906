require 'rails_helper'
RSpec.describe 'Users Order Show Page' do
  describe 'when a logged in user has placed orders' do
    before :each do
      @user = User.create!(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'Colorado', zip: '80205', email: 'StarPerfect@gmail.com', password: 'Hello123')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
      @order_2 = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
      @order_3 = Order.create(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip, user_id: @user.id)
      @item_order_1 = @order_1.item_orders.create(item: @tire, price: @tire.price, quantity: 2)
      @item_order_2 = @order_2.item_orders.create(item: @paper, price: @paper.price, quantity: 20)
      @item_order_3 = @order_3.item_orders.create(item: @pencil, price: @pencil.price, quantity: 5)
      @item_order_4 = @order_2.item_orders.create(item: @pencil, price: @pencil.price, quantity: 1)

    end

    it "User Profile displays Orders, When I visit my Profile Orders page
    I see every order I've made, which includes the following information:
    the ID of the order, which is a link to the order show page
    the date the order was made
    the date the order was last updated
    the current status of the order
    the total quantity of items in the order
    the grand total of all items for that order" do
      visit '/profile/orders'

      expect(page).to have_link("Order ID ##{@order_1.id}")
      expect(page).to have_link("Order ID ##{@order_2.id}")
      expect(page).to have_link("Order ID ##{@order_3.id}")

      expect(page).to have_content(@order_1.created_at)
      expect(page).to have_content(@order_2.created_at)
      expect(page).to have_content(@order_3.created_at)

      expect(page).to have_content(@order_1.status)
      expect(page).to have_content(@order_2.status)
      expect(page).to have_content(@order_3.status)

      expect(page).to have_content("Number of Items Ordered: #{@order_1.item_orders.count}")
      expect(page).to have_content("Number of Items Ordered: #{@order_2.item_orders.count}")
      expect(page).to have_content("Number of Items Ordered: #{@order_3.item_orders.count}")

      expect(page).to have_content(@order_1.grandtotal)
      expect(page).to have_content(@order_2.grandtotal)
      expect(page).to have_content(@order_3.grandtotal)
    end

#     As a registered user
# When I visit my Profile Orders page
# And I click on a link for order's show page
# My URL route is now something like "/profile/orders/15"
# I see all information about the order, including the following information:
# - the ID of the order
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - each item I ordered, including name, description, thumbnail, quantity, price and subtotal
# - the total quantity of items in the whole order
# - the grand total of all items for that order
    it 'can click on order from Order History page and view orders details' do
      visit '/profile/orders'

      click_link "Order ID ##{@order_2.id}"
save_and_open_page
      expect(current_path).to eq("/profile/orders/#{@order_2.id}")
      expect(page).to have_content("Order ID ##{@order_2.id} Details")
      expect(page).to have_content("Order Placed On: #{@order_2.created_at}")
      expect(page).to have_content("Last Updated On: #{@order_2.updated_at}")
      expect(page).to have_content("Current Status: #{@order_2.status}")

      expect(page).to have_content('Lined Paper')
      expect(page).to have_content('Great for writing on!')
      # expect(page).to have_content()
      expect(page).to have_content(20)
      expect(page).to have_content(20)
      expect(page).to have_content(400)


      expect(page).to have_content("Number of Items Ordered: #{@order_2.item_orders.count}")
      expect(page).to have_content("Order Total: $#{@order_2.grandtotal}")
    end
  end
end
