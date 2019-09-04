require 'rails_helper'

describe 'User Registration' do
  describe 'when user clicks on register' do
    it 'they can fill out a form to register new user' do

      visit '/items'

      within 'nav' do
        click_link 'Register'
      end

      name = "alec"
      address = "234 Main"
      city = "Denver"
      state = "CO"
      zip = 80204
      email = "alec@gmail.com"
      password = "password"
      password_confirm = "password"

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip
      fill_in :email, with: email
      fill_in :password, with: password
      fill_in :password_confirm, with: password_confirm

      click_button "Submit"

      expect(current_path).to eq("/profile")
    end
  end
end
# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page ('/register')
# And I see a form where I input the following data:
# - my name
# - my street address
# - my city
# - my state
# - my zip code
# - my email address
# - my preferred password
# - a confirmation field for my password
#
# When I fill in this form completely,
# And with a unique email address not already in the system
# My details are saved in the database
# Then I am logged in as a registered user
# I am taken to my profile page ("/profile")
# I see a flash message indicating that I am now registered and logged in
