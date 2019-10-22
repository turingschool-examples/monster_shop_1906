require 'rails_helper'

describe "on the nav bar" do
  describe "as a merchant user" do
    it "sees regular user links plus a link to the dashboard" do

      merchant = User.create( name: 'Sally Q',
                              address: '123 Fake St',
                              city: 'Denver',
                              state: 'Colorado',
                              zip: 80111,
                              email: 'merchant@merchant.com',
                              password: 'password',
                              role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/'

      within '.topnav' do
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
        expect(page).to have_link('Dashboard')
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Login')
      end

      expect(page).to have_content("Logged in as #{merchant.name}")
    end
  end
end