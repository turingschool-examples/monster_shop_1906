require 'rails_helper'

describe "on the nav bar" do
  describe "as a regular user" do
    it "sees visitor links plus profile and logout" do

      user = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'user@user.com',
                          password: 'password',
                          role: 0)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      within '.topnav' do
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Login')
      end

      expect(page).to have_content("Logged in as #{user.name}")

    end
  end
end

# As a registered regular user
# I see the same links as a visitor
# Plus the following links
# - a link to my profile page ("/profile")
# - a link to log out ("/logout")
#
# Minus the following links
# - I do not see a link to log in or register
#
# I also see text that says "Logged in as Ian Douglas" (or whatever my name is)