require 'rails_helper'


# As a merchant employee or admin
# When I visit an order show page from my dashboard
# I see the customer's name and address
# I only see the items in the order that are being purchased from my merchant
# I do not see any items in the order being purchased from other merchants
# For each item, I see the following information:
# - the name of the item, which is a link to my item's show page OK
# - an image of the item
# - my price for the item
# - the quantity the user wants to purchase

RSpec.describe "Merchant Order Show Page" do
  before :each do

    @regular_user_1 = create(:user)

    # Using to test ONLY merchant_1_shop items appear
    @merchant_shop_1 = create(:merchant, name: "Merchant Shop 1")
      @item_1 = @merchant_shop_1.items.create!(attributes_for(:item, name: "Item 1" ))
      @item_2 = @merchant_shop_1.items.create!(attributes_for(:item, name: "Item 2"))

    # Using to test ONLY merchant_1_shop items appear
    @merchant_shop_2 = create(:merchant, name: "Merchant Shop 2")
      @item_3 = @merchant_shop_2.items.create!(attributes_for(:item, name: "Item 3"))
      @item_4 = @merchant_shop_2.items.create!(attributes_for(:item, name: "Item 4"))

    @order_1 = create(:order)
      #merchant_shop_1 order
      @item_order_1 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_1, quantity: 2, price: @item_1.price)
      @item_order_2 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_2, quantity: 8, price: @item_2.price)
      #merchant_shop_2 order
      @item_order_3 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_3, quantity: 10, price: @item_3.price)

    @order_2 = create(:order)
      #merchant_shop_1 order, should not appear in order_1 merchant show page
      @item_order_4 = @regular_user_1.item_orders.create!(order: @order_2, item: @item_2, quantity: 18, price: @item_2.price)

    @merchant_admin_1 = create(:user, role: 1, merchant: @merchant_shop_1)
    @merchant_employee_1 = create(:user, role: 2, merchant: @merchant_shop_1)

  end

  it 'can show all the merchants orders' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin_1)

    visit merchant_user_order_path(@order_1)


    within "#item_orders-#{@item_order_1.id}" do
      expect(page).to have_content(@item_order_1.item.name)
      expect(page).to have_link(item_path(@item_order_1.item))
      expect(page).to have_css("img[src*='#{@item_order_1.item.image}']")
      expect(page).to have_content(@item_order_1.item.price)
      expect(page).not_to have_content(@item_order_4.item.price)
    end

    within "#item_orders-#{@item_order_2.id}" do
      expect(page).to have_content(@item_order_2.item.name)
      expect(page).to have_link(item_path(@item_order_2.item))
      expect(page).to have_css("img[src*='#{@item_order_2.item.image}']")
      expect(page).to have_content(@item_order_2.item.price)
    end

    expect(page).not_to have_css("#item_orders-#{@item_order_3.id}")
    expect(page).not_to have_content(@item_order_3.item.name)

    expect(page).not_to have_css("#item_orders-#{@item_order_4.id}")
  end
end
