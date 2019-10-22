require 'rails_helper'

RSpec.describe 'Default user login page' do
  it 'needs to login with valid credentials' do
    user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123")

    visit '/login'

    fill_in :email, with: 'test@gmail.com'
    fill_in :password, with: 'password123'

    click_button 'Login'

    expect(current_path).to eq('/profile')

    expect(page).to have_content("#{user.name}, you have successfully logged in.")

    within 'nav' do
      expect(page).to have_link('Logout')
      expect(page).to_not have_link('Login')
      expect(page).to_not have_link('Register')
    end
  end

  it 'cannot login with invalid credentials' do
    user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123")

    visit '/login'

    fill_in :email, with: 'test@gmail.com'
    fill_in :password, with: 'billybob'

    click_button 'Login'

    expect(current_path).to eq('/login')
    expect(page).to have_content("Sorry, credentials were invalid. Please try again.")
  end
end
