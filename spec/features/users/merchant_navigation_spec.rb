# [ ] done
#
# User Story 4, Merchant Navigation
#
# As a merchant employee or admin
# I see the same links as a regular user
# Plus the following links:
# - a link to my merchant dashboard ("/merchant")
require 'rails_helper'

RSpec.describe 'Merchant Navigation' do
  describe 'As a Merchat user' do
    it 'I see the same links as a regular user plus a to my dashboard' do

      visit "/"
      expect(page).to have_link("Dashbord")

      visit '/admin'
      expect(page).to have_link("404 error")
    end
  end
end
