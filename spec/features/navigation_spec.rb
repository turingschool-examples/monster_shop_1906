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

  describe "As an Admin User" do
    it "I see appropriate links in the nav bar" do
      admin_user = User.create!(name: "Leslie Knope",
                    address: "14 Somewhere Ave",
                    city: "Pawnee",
                    state: "IN",
                    zipcode: "18501",
                    email: "recoffice@email.com",
                    password: "Waffles",
                    role: 3)

      visit '/login'

      within 'nav' do
        click_link('Login')
      end

      fill_in :email, with: admin_user.email
      fill_in :password, with: admin_user.password

      click_button "Submit"

      visit items_path

      within 'nav' do
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")
        expect(page).to have_link("All Users")
        expect(page).to have_link("Admin Dashboard")


        expect(page).to_not have_link("Login")
        expect(page).to_not have_link("Register")
        expect(page).to_not have_link("Cart: 0")
      end
    end
  end
end
