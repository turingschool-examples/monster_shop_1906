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

      visit '/merchants'

      within 'nav' do
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")

      end
    end
  end
end
