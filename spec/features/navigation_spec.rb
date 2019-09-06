#
# As a visitor
# I see a navigation bar
# This navigation bar includes links for the following:
# - a link to return to the welcome / home page of the application ("/") OK
# - a link to browse all items for sale (items_path) OK
# - a link to see all merchants ("/merchants") OK
# - a link to my shopping cart ("/cart") OK
# - a link to log in ("/login") OK
# - a link to the user registration page ("/register") Ok

require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit merchants_path

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq(items_path)

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq(merchants_path)
    end

    it "I can see a cart indicator on all pages and click link" do
      visit merchants_path

      within 'nav' do
        expect(page).to have_link("Cart: 0")
        click_link("Cart: 0")
      end

      expect(current_path).to eq("/cart")

      visit items_path

      within 'nav' do
        expect(page).to have_link("Cart: 0")
      end
    end

    it 'can return to the welcome / home page of the application' do
      visit merchants_path

      within 'nav' do
        click_link('Home')
      end

      expect(current_path).to eq(root_path)
    end

    it 'I can click login link' do
      visit root_path

      within 'nav' do
        click_link('Login')
      end

      expect(current_path).to eq('/login')
    end

    it 'I can click on registration link' do
      visit root_path

      within 'nav' do
        click_link('Register')
      end

      expect(current_path).to eq('/register')
    end
  end

  describe "As a Registered User" do
    it "I see profile and logout links but not login and register links on navigation bar" do
      regular_user = User.create!(name: "George Jungle",
                    address: "1 Jungle Way",
                    city: "Jungleopolis",
                    state: "FL",
                    zipcode: "77652",
                    email: "junglegeorge@email.com",
                    password: "Tree123")

      visit '/login'

      within 'nav' do
        click_link('Login')
      end

      fill_in :email, with: regular_user.email
      fill_in :password, with: regular_user.password

      click_button "Submit"

      expect(current_path).to eq('/profile')


      within 'nav' do
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")

        expect(page).to_not have_link("Login")
        expect(page).to_not have_link("Register")
      end

      expect(page).to have_content("Logged in as #{regular_user.name}")
    end
  end

  describe "As a Merchant Employee/Admin" do
    it "I see profile, logout, and merchant dashboard links on navigation bar" do
      merchant_user = User.create!(name: "Michael Scott",
                    address: "1725 Slough Ave",
                    city: "Scranton",
                    state: "PA",
                    zipcode: "18501",
                    email: "michael.s@email.com",
                    password: "WorldBestBoss",
                    role: 2)

      visit '/login'

      within 'nav' do
        click_link('Login')
      end

      fill_in :email, with: merchant_user.email
      fill_in :password, with: merchant_user.password

      click_button "Submit"

      expect(current_path).to eq('/merchant')


      within 'nav' do
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")
        expect(page).to have_link("Merchant Dashboard")

        expect(page).to_not have_link("Login")
        expect(page).to_not have_link("Register")
      end

      expect(current_path).to eq('/merchant')
      expect(page).to have_content("Logged in as #{merchant_user.name}")
    end
  end
end
