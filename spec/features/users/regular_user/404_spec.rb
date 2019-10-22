require 'rails_helper'

describe "as a regular user" do
  describe "when I visit a path I am not supposed to access" do
    it "sees an 404 error" do

      user = User.create!( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'user@user.com',
                          password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'

      expect(page).to_not have_content("The page you were looking for doesn't exist.")

    end
  end
end