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
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zipcode can't be blank")
    expect(page).to have_content("Password digest can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password can't be blank")
  end

  it "doesn't allow duplicate email registrations and returns me to the registration page with a filled-out form, without saving my details and I see a flash message saying that email is already in use" do

    visit "/register"

    regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")

    fill_in :name, with: "George Jungle"
    fill_in :address, with: "1 Jungle Way"
    fill_in :city, with: "Jungleopolis"
    fill_in :state, with: "FL"
    fill_in :zipcode, with: "77652"
    fill_in :email, with: "junglegeorge@email.com"
    fill_in :password, with: "Tree123"

    click_on "Submit"

    expect(current_path).to eq("/register")

    expect(page).to have_content("That email is already in use. Please log in or choose a different email.")

    expect(page).to have_content("George Jungle")
    expect(page).to have_content("1 Jungle Way")
    expect(page).to have_content("Jungleopolis")
    expect(page).to have_content("FL")
    expect(page).to have_content("77652")
    expect(page).not_to have_content("junglegeorge@email.com")
    expect(page).not_to have_content("Tree123")


  end
  # As a visitor
  # When I visit the user registration page
  # If I fill out the registration form
  # But include an email address already in the system
  # Then I am returned to the registration page
  # My details are not saved and I am not logged in
  # The form is filled in with all previous data except the email field and password fields
  # I see a flash message telling me the email address is already in use
end
