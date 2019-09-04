#
# As a visitor
# I see a navigation bar
# This navigation bar includes links for the following:
# - a link to return to the welcome / home page of the application ("/") OK
# - a link to browse all items for sale ("/items") OK
# - a link to see all merchants ("/merchants") OK
# - a link to my shopping cart ("/cart") OK
# - a link to log in ("/login") NEEDED
# - a link to the user registration page ("/register") NEEDED

require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end

    it 'can return to the welcome / home page of the application' do
      visit '/merchants'

      within 'nav' do
        click_link('Home')
      end

      expect(current_path).to eq('/')
    end

    it ''
  end
end
