require 'rails_helper'

RSpec.describe "Admin_user User Index Page " do
  before :each do
    @admin_user = User.create!(name: "Leslie Knope",
                  address: "14 Somewhere Ave",
                  city: "Pawnee",
                  state: "IN",
                  zipcode: "18501",
                  email: "recoffice@email.com",
                  password: "Waffles",
                  role: 3)
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  it "displays pertinent info for the specified user" do
    visit admin_users_path

    click_link(@regular_user.name)

    expect(current_path).to eq(admin_user_path(@regular_user))

    within "#user-info-#{@regular_user.id}" do
      expect(page).to have_content(@regular_user.name)
      expect(page).to have_content(@regular_user.address)
      expect(page).to have_content(@regular_user.city)
      expect(page).to have_content(@regular_user.state)
      expect(page).to have_content(@regular_user.zipcode)
      expect(page).to have_content(@regular_user.email)
    end

    expect(page).to_not have_link("Edit Profile")

    visit admin_users_path

    click_link(@merchant_user.name)

    expect(current_path).to eq(admin_user_path(@merchant_user))

    within "#user-info-#{@merchant_user.id}" do
      expect(page).to have_content(@merchant_user.name)
      expect(page).to have_content(@merchant_user.address)
      expect(page).to have_content(@merchant_user.city)
      expect(page).to have_content(@merchant_user.state)
      expect(page).to have_content(@merchant_user.zipcode)
      expect(page).to have_content(@merchant_user.email)
    end

    expect(page).to_not have_link("Edit Profile")
  end
end
