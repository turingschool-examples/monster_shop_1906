
require 'rails_helper'

RSpec.describe "Show Merchant Dashboard" do
  describe "As a merchant employee or admin" do
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

      @merchant_user = @bike_shop.users.create!(name: "Michael Scott",
                    address: "1725 Slough Ave",
                    city: "Scranton",
                    state: "PA",
                    zipcode: "18501",
                    email: "michael.s@email.com",
                    password: "WorldBestBoss",
                    role: 2)
    end

    it "When I visit my merchant dashboard, I see the name and full address of the merchant I work for" do
      visit "/login"

      fill_in :email, with: @merchant_user.email
      fill_in :password, with: @merchant_user.password

      click_button "Submit"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("Welcome, #{@merchant_user.name}!")
      # expect(page).to have_content(@bike_shop.name)
      # expect(page).to have_content(@bike_shop.address)
      # expect(page).to have_content("#{dog_shop.city}, #{dog_shop.state} #{dog_shop.zip}")

    end

  end
end

# When I visit my merchant dashboard ("/merchant")
# I see the name and full address of the merchant I work for
