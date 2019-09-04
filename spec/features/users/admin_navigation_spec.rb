# User Story 5, Admin Navigation
#
# As an admin user
# I see the same links as a regular user
# Plus the following links
# - a link to my admin dashboard ("/admin")
# - a link to see all users ("/admin/users")
#
# Minus the following links/info
# - a link to my shopping cart ("/cart") or count of cart items

require 'rails_helper'

RSpec.describe 'Admin Navigation' do
  describe 'As a admin user' do
    it 'I see the same links as a regular user plus link to my asmin
    dashboard and a link to see all users, but not a cart link nor cart counter' do

    visit '/'

    expect(page).to have_link("Dashbord")
    expect(page).to have_link("All Users")
    expect(page).to_not have_link("Cart")

    visit '/merchant'
    expect(page).to have_link("404 error")

    visit '/cart'
    expect(page).to have_link("404 error")
    end
  end
end
