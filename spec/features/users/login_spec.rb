require 'rails_helper'

# User Story 13, User can Login
#
# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in

RSpec.describe "User Login" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
    @merchant_user = User.create!(name: "Michael Scott",
                  address: "1725 Slough Ave",
                  city: "Scranton",
                  state: "PA",
                  zipcode: "18501",
                  email: "michael.s@email.com",
                  password: "WorldBestBoss",
                  role: 2)
    @admin_user = User.create!(name: "Leslie Knope",
                  address: "14 Somewhere Ave",
                  city: "Pawnee",
                  state: "IN",
                  zipcode: "18501",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3)
  end

  it "can log in a regular user" do
    visit "/login"

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password

    click_button "Submit"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Welcome, #{@regular_user.name}!")
  end

  it "can log in a merchant user" do
    visit "/login"

    fill_in :email, with: @merchant_user.email
    fill_in :password, with: @merchant_user.password

    click_button "Submit"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Welcome, #{@merchant_user.name}!")
  end

  it "can log in an admin user" do
    visit "/login"

    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password

    click_button "Submit"

    expect(current_path).to eq("/admin")
    expect(page).to have_content("Welcome, #{@admin_user.name}!")
  end
end
