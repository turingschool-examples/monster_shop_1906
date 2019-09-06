require 'rails_helper'

RSpec.describe "Admin_user Merchant Index Page " do
  before :each do
    @admin_user = User.create!(name: "Leslie Knope",
                  address: "14 Somewhere Ave",
                  city: "Pawnee",
                  state: "IN",
                  zipcode: "18501",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3)
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
    @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203, enabled?: false)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  it "shows all merchants with pertinent info and links to individual merchants" do
    visit merchants_path

    within "#merchant-#{@bike_shop.id}" do
      expect(page).to have_link(@bike_shop.name)
      expect(page).to have_content(@bike_shop.city)
      expect(page).to have_content(@bike_shop.state)
      expect(page).to have_button("Disable")
    end

    within "#merchant-#{@dog_shop.id}" do
      expect(page).to have_link(@dog_shop.name)
      expect(page).to have_content(@dog_shop.city)
      expect(page).to have_content(@dog_shop.state)
      expect(page).to have_button("Enable")
    end
  end
end
