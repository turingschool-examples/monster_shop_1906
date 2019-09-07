require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop",
                  address: '123 Bike Rd.',
                  city: 'Richmond',
                  state: 'VA',
                  zip: 23137)

    @chain = @bike_shop.items.create!(name: "Chain",
                  description: "It'll never break!",
                  price: 50,
                  image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588",
                  inventory: 5)

    @merchant_admin = @bike_shop.users.create!(name: "Michael Scott",
                  address: "1725 Slough Ave",
                  city: "Scranton",
                  state: "PA",
                  zipcode: "18501",
                  email: "michael.s@email.com",
                  password: "WorldBestBoss",
                  role: 2)
    @merchant_employee = @bike_shop.users.create!(name: "Dwight Schrute",
                  address: "1725 Slough Ave",
                  city: "Scranton",
                  state: "PA",
                  zipcode: "18501",
                  email: "dwight@email.com",
                  password: "MichaelIsTheBest",
                  role: 1)

  end

  it 'merchant admin sees link to view shop items' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_admin)

    visit merchant_user

    within "#dashboard-link" do
      click_link("View Items")
    end

    expect(current_path).to eq("/merchant/items")
    
    within "#shop-items" do
      expect(page).to have_content.(@chain.name)
    end
  end

  it 'merchant employee sees link to view shop items' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_employee)

    visit merchant_user

    within "#dashboard-link" do
      click_link("View Items")
    end

    expect(current_path).to eq("/merchant/items")

    within "#shop-items" do
      expect(page).to have_content.(@chain.name)
    end
  end
end
