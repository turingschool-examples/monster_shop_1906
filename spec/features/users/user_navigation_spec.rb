# User Story 3, User Navigation
#
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

require 'rails_helper'

RSpec.describe 'User Navigation' do
  describe 'As a registered regular user' do
    it 'I see the same links as a visitor plus a link to my profile and logout' do
      user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", role:0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchants'

      within 'nav' do
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")
      end
      # visit '/merchant'
      # expect(page).to have_link("404 error")
      #
      #
      # visit '/admin'
      # expect(page).to have_link("404 error")
    end
  end
end
