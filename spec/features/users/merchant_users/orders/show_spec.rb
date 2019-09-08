require 'rails_helper'

RSpec.describe "Merchant Order Show Page" do
  before :each do

    @regular_user_1 = create(:user)

    @merchant_shop_1 = create(:merchant)

    @item_1 = @merchant_shop_1.items.create!(attributes_for(:item))
    @item_2 = @merchant_shop_1.items.create!(attributes_for(:item))

    @order_1 = create(:order)
      @item_order_1 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_1, quantity: 1, price: @item_1.price)
      @item_order_2 = @regular_user_1.item_orders.create!(order: @order_1, item: @item_2, quantity: 3, price: @item_2.price)

    @merchant_admin = create(:user, role: 1, merchant: @merchant_shop_1)
    @merchant_employee = create(:user, role: 2, merchant: @merchant_shop_1)
  end

  it 'can show all the merchants orders' do
    # binding.pry
    # @item_1.item_orders -> item_orders for item
    # @merchant_admin.merchant.item_orders --> orders associated with merchant user
    # @merchant_shop_1.item_orders --> orders associated with merchant shop
  end
end
