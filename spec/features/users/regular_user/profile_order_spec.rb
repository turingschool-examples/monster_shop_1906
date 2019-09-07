# User Story 23
# As a registered user
# When I add items to my cart
# And I visit my cart
# I see a button or link indicating that I can check out
# And I click the button or link to check out
#
# An order is created in the system,
# which has a status of "pending"
# That order is associated with my user
# I am taken to my orders page ("/profile/orders")
# I see a flash message telling me my order was created
# I see my new order listed on my profile orders page
# My cart is now empty

require 'rails_helper'

RSpec.describe "User Profile Order Page" do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    merchant_1 = create(:merchant)
    item_1 = merchant_1.items.create!(attributes_for(:item))
    item_2 = merchant_1.items.create!(attributes_for(:item))

    visit item_path(item_1)
    click_on "Add To Cart"
    visit item_path(item_2)
    click_on "Add To Cart"

    visit cart_path
    click_on "Checkout"

    @order_1 = create(:order)
    click_on "Create Order"
  end

  it "see a list of my orders and a flash message confirming my recent order" do
    visit "profile/orders"

    within 'nav' do
      expect(page).to have_content("Cart: 0")
    end

    expect(@order_1.status).to eq("pending")
    expect(page).to have_content("Your order has been created!")
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(order_1.name)

  end
end
