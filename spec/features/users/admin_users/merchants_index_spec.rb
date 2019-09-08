require 'rails_helper'

RSpec.describe "Admin_user Merchant Index Page " do
  before :each do
    @admin_user = create(:user, role: 3)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

    @merchant_1 =  create(:merchant)
    @merchant_2 =  create(:merchant, enabled?: false)
  end

  it "shows all merchants with pertinent info and links to individual merchants" do
    visit merchants_path

    within "#merchant-#{@merchant_1.id}" do
      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_content(@merchant_1.city)
      expect(page).to have_content(@merchant_1.state)
      expect(page).to have_button("Disable")
    end

    within "#merchant-#{@merchant_2.id}" do
      expect(page).to have_content(@merchant_2.city)
      expect(page).to have_content(@merchant_2.state)
      expect(page).to have_button("Enable")
      click_link(@merchant_2.name)
    end

    expect(current_path).to eq(admin_merchant_path(@merchant_2))
  end

  it "has a button that disables/enables merchants" do
    visit merchants_path
    within "#merchant-#{@merchant_1.id}" do
      expect(page).to have_content("Current status: enabled")
      click_button("Disable")
    end

    expect(current_path).to eq(merchants_path)
    expect(page).to have_content("#{@merchant_1.name} is now disabled")

    within "#merchant-#{@merchant_1.id}" do
      expect(page).to have_content("Current status: disabled")
      click_button("Enable")
    end

    expect(current_path).to eq(merchants_path)
    expect(page).to have_content("#{@merchant_1.name} is now enabled")
  end
end
