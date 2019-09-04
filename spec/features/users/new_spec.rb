require 'rails_helper'

RSpec.describe "Registering User" do
  it "creates new user" do
    visit "/register"

    user_name = "Larry Pug"
    user_address = "123 Sesame St"
    user_city = "Denver"
    user_state = "CO"
    user_zipcode = "80222"
    user_email = "larrypug@email.com"
    user_password = "password123"
    user_confirm_password = "password123"

    fill_in :name, with: user_name
    fill_in :address, with: user_address
    fill_in :city, with: user_city
    fill_in :state, with: user_state
    fill_in :zipcode, with: user_zipcode
    fill_in :email, with: user_email
    fill_in :password, with: user_password
    fill_in :confirm_password, with: user_confirm_password

    click_on "Submit"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Welcome #{user_name}! You are now registered and logged in.")
    expect(page).to_not have_link("Login")
    expect(page).to_not have_link("Register")
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
