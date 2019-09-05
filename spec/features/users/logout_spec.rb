
require 'rails_helper'

RSpec.describe "User Logout" do
  before :each do
    @regular_user = User.create!(name: "George Jungle",
                  address: "1 Jungle Way",
                  city: "Jungleopolis",
                  state: "FL",
                  zipcode: "77652",
                  email: "junglegeorge@email.com",
                  password: "Tree123")
  end

  it "can logout user and redirect to the home page with a flash messages indicating that I am logged out and all shopping cart items are deleted" do
    visit "/login"

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password

    click_button "Submit"

    within 'nav' do
      click_link 'Logout'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are logged out!")
    expect(page).to have_content("Cart: 0")
  end
end
