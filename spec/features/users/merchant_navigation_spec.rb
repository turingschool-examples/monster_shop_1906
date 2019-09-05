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
      user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", role:2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_link("Dashboard")
    end
  end
end
