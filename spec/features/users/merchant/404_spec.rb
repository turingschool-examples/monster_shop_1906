require 'rails_helper'

describe "as a merchant user" do
  describe "when I visit a path I am not supposed to access" do
    it "sees an 404 error" do

      merchant = User.create!( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'merchant@merchant.com',
                          password: 'password',
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'

      expect(page).to_not have_content("The page you were looking for doesn't exist.")

    end
  end
end