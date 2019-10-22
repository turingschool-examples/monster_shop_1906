
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

      within 'nav' do
        click_link 'Home'
      end

      expect(current_path).to eq('/')
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

    it 'I can see a link to log in on all pages' do
      visit '/merchants'

      within 'nav' do
        click_link "Login"
      end

      expect(current_path).to eq('/login')

      visit '/items'

      within 'nav' do
        expect(page).to have_content('Login')
      end
    end

    it 'I can see a link to register on all pages' do
      visit '/merchants'

      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq('/register')

      visit '/items'

      within 'nav' do
        expect(page).to have_content('Register')
      end
    end
  end

  describe 'As a user' do
    it 'I see the navbar with links with profile and log out, not login or register' do
      user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      within 'nav' do
        expect(page).to have_content('All Merchants')
        expect(page).to have_content('All Items')
        expect(page).to have_content('Cart: 0')
        expect(page).to have_content('Logged in as Patti')
        expect(page).to have_content('Log out')
        expect(page).to have_content('Profile')
        expect(page).to_not have_content('Login')
        expect(page).to_not have_content('Register')
      end
    end
  end

  describe 'As a merchant' do
    it 'I see navbar with links to all pages, profile, logout, dashboard, not login or register' do
      merchant = User.create(name: 'Ross', address: '56 HairGel Ave', city: 'Las Vegas', state: 'Nevada', zip: '65041', email: 'dinosaurs_rule@gmail.com', password: 'rachel', role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/'

      within 'nav' do
        expect(page).to have_link('All Merchants')
        expect(page).to have_link('All Items')
        expect(page).to have_link('Cart: 0')
        expect(page).to have_content('Logged in as Ross')
        expect(page).to have_link('Log out')
        expect(page).to have_link('Profile')
        expect(page).to have_link('Dashboard')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')

        click_link 'Dashboard'
      end
      expect(current_path).to eq('/merchant')
    end
  end

  # Admin Test
end
