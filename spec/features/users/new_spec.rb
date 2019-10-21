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

    it "gets an error if form not filled in correctly" do
      visit '/register'

      click_button 'Complete Registration'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")

      fill_in :name, with: "Bob J"
      fill_in :address, with: "123 Main St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80211"
      fill_in :email, with: "bobj@gmail.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "Password"
      click_button 'Complete Registration'

      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it "cannot create a user with a already used email" do

      user = User.create(name: 'Bob J', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'user@user.com', password: 'password')

      visit '/register'

      fill_in :name, with: "Bob J"
      fill_in :address, with: "123 Main St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80211"
      fill_in :email, with: "user@user.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "Password"
      click_button 'Complete Registration'

      expect(page).to have_content('Email has already been taken')
    end
  end
end