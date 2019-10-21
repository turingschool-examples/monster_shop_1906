require 'rails_helper'

RSpec.describe 'New User Page' do
  describe 'as a visitor registering as a new user' do
    it "lets me fill in a form on '/register' to make a new user" do
      visit '/'
      click_link 'Register'

      expect(current_path).to eq('/register')

      fill_in :name, with: "Bob J"
      fill_in :address, with: "123 Main St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80211"
      fill_in :email, with: "bobj@gmail.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"
      click_button 'Complete Registration'

      expect(current_path).to eq('/profile')
      expect(page).to have_content("You are now registered and logged in")
    end
  end
end



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
