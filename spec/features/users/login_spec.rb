require 'rails_helper'

RSpec.describe "User Login" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
    @merchant_employee = User.create!(name: "Dwight Schrute",
                  address: "175 Beet Rd",
                  city: "Scranton",
                  state: "PA",
                  zipcode: "18501",
                  email: "dwightkschrute@email.com",
                  password: "IdentityTheftIsNotAJoke",
                  role: 1)
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
    expect(page).to have_content("Logged in as #{@regular_user.name}")

    visit "/login"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("You are already logged in")
  end

  it "can log in a merchant employee" do
    visit "/login"

    fill_in :email, with: @merchant_employee.email
    fill_in :password, with: @merchant_employee.password

    click_button "Submit"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Logged in as #{@merchant_employee.name}")

    visit "/login"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("You are already logged in")
  end

  it "can log in a merchant user" do
    visit "/login"

    fill_in :email, with: @merchant_user.email
    fill_in :password, with: @merchant_user.password

    click_button "Submit"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Logged in as #{@merchant_user.name}")

    visit "/login"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("You are already logged in")
  end

  it "can log in an admin user" do
    visit "/login"

    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password

    click_button "Submit"

    expect(current_path).to eq("/admin")
    expect(page).to have_content("Logged in as #{@admin_user.name}")

    visit "/login"

    expect(current_path).to eq("/admin")
    expect(page).to have_content("You are already logged in")
  end

  it "displays a flash message for invalid entries" do
    visit "/login"

    fill_in :email, with: @admin_user.email
    fill_in :password, with: "Gibberish"

    click_button "Submit"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Please enter valid user information")

    visit "/login"

    fill_in :email, with: ""
    fill_in :password, with: @merchant_user.password

    click_button "Submit"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Please enter valid user information")
  end
end
