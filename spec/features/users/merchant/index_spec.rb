require 'rails_helper'

describe 'On the merchant dashboard /merchant' do
  describe 'as a merchant employee/admin (above a default user)' do
    before(:each) do
      merchant_employee = User.create(name: 'Drone', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'employee@employee.com', password: 'password', role: 1 )
      merchant_admin = User.create(name: 'Boss', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'boss@boss.com', password: 'password', role: 2 )
      @chester_the_merchant = Merchant.create(name: "Chester's Shop", address: '456 Terrier Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      merchant_user_1 = MerchantUser.create(user_id: merchant_employee.id, merchant_id: @chester_the_merchant.id)
      merchant_user_2 = MerchantUser.create(user_id: merchant_admin.id, merchant_id: @chester_the_merchant.id)

      pull_toy = @chester_the_merchant.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = @chester_the_merchant.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      user = User.create(name: 'Customer Sally', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'user@user.com', password: 'password' )


      @order = user.orders.create!(name: user.name, address: user.address, city: user.city, state: user.state, zip: user.zip, user_id: user.id)
      item_order_1 = @order.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
      item_order_2 = @order.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 1)





      @users = [merchant_employee, merchant_admin]
    end
    it 'has the name and full address of the merchant I work for' do

      @users.each do |user|
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit '/merchant'

        within '.employer-info' do
          expect(page).to have_content(@chester_the_merchant.name)
          expect(page).to have_content(@chester_the_merchant.address)
          expect(page).to have_content(@chester_the_merchant.city)
          expect(page).to have_content(@chester_the_merchant.state)
          expect(page).to have_content(@chester_the_merchant.zip)
        end
      end
    end

    it 'shows details for pending orders' do
      @users.each do |user|
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit '/merchant'
        within '.pending-orders' do
          expect(page).to have_link("Order #: #{@order.id}")
          expect(page).to have_content(@order.created_date)
          expect(page).to have_content(@order.item_count)
          expect(page).to have_content(@order.grandtotal)
        end
      end
    end


#       As a merchant employee or admin
# When I visit my merchant dashboard ("/merchant")
# If any users have pending orders containing items I sell
# Then I see a list of these orders.
# Each order listed includes the following information:
# - the ID of the order, which is a link to the order show page ("/merchant/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order
  end
end
