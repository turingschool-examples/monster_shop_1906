
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

      visit '/cart'

      within 'nav' do
        within "#home-pic" do
          find(:css, 'img[src*="https://www.davidbrassrarebooks.com/pictures/03815_8.jpg?v=1478033010"]').click
        end
      end

      expect(current_path).to eq("/")

      within 'nav' do
        click_link 'Login'
      end

      expect(current_path).to eq('/login')

      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq('/registration')

    end
  end
end
