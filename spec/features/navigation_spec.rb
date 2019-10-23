
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within('nav') { click_link 'Home' }
      expect(current_path).to eq('/')

      within('nav') { click_link 'Items' }
      expect(current_path).to eq('/items')

      within('nav') { click_link 'Merchants' }
      expect(current_path).to eq('/merchants')

      within('nav') { click_link 'Login' }
      expect(current_path).to eq('/login')

      within('nav') { click_link 'Register' }
      expect(current_path).to eq('/register')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within('nav') { expect(page).to have_content("Cart (0)") }

      visit '/items'

      within('nav') { expect(page).to have_content("Cart (0)") }
    end
  end
end
