
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

      expect(current_path).to eq('/users/new')

      visit '/items'

      within 'nav' do
        expect(page).to have_content('Register')
      end
    end
  end
  describe 'As a user' do
    it 'I see the navbar with links to all pages' do
      user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', e_mail: 'pattimonkey34@gmail.com', password: 'banana')

      visit '/'

      click_link 'Login'

      fill_in :e_mail, with: user.e_mail
      fill_in :password, with: user.password
      click_button 'Log In'

      expect(current_path).to eq('/profile')
      expect(page).to have_content('Welcome, Patti!')
      expect(page).to have_content('Address: 953 Sunshine Ave')
      expect(page).to have_content('City: Honolulu')
      expect(page).to have_content('State: Hawaii')
      expect(page).to have_content('Zip Code: 96701')
      expect(page).to have_content('E-mail: pattimonkey34@gmail.com')

      within 'nav' do
        expect(page).to have_content('All Merchants')
        expect(page).to have_content('All Items')
        expect(page).to have_content('Cart: 0')
        expect(page).to have_content('Log out')
        expect(page).to_not have_content('Login')
        expect(page).to_not have_content('Register')
      end
    end
  end


end
