require 'rails_helper'

RSpec.describe "Admin_user Merchant Show Page " do
  before :each do
    @admin_user = create(:user, role: 3)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

    @merchant_1 =  create(:merchant)
  end

  it "has pertinent merchant info indentical to the merchant dashboard" do
    visit admin_merchant_path(@merchant_1)

    expect(page).to have_content("This needs to be just like the merchant dashboard- FIX ME LATER")
  end
end
