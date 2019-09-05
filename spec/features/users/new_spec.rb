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
    expect(page).to have_content("Hello, #{user_name}!")
    expect(page).to_not have_link("Login")
    expect(page).to_not have_link("Register")
  end

  it "when I visit the user registration page and do not fill in the form completely, I am returned to the registration page and see a flash message that I am missing required fields" do

    visit "/register"

    click_on "Submit"

    expect(current_path).to eq("/register")
    expect(page).to have_content("Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zipcode can't be blank, Password digest can't be blank, Email can't be blank, Email is invalid, and Password can't be blank")
  end
end
