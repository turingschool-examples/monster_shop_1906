require 'rails_helper'

RSpec.describe 'User login page' do
  describe 'default user' do
    before :each do
      @user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123")
    end
    it 'needs to login with valid credentials' do
      visit '/login'

      fill_in :email, with: 'test@gmail.com'
      fill_in :password, with: 'password123'

      click_button 'Login'

      expect(current_path).to eq('/profile')

      expect(page).to have_content("#{@user.name}, you have successfully logged in.")

      within 'nav' do
        expect(page).to have_link('Logout')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Register')
      end
    end

    it 'cannot login with invalid credentials' do

      visit '/login'

      fill_in :email, with: 'test@gmail.com'
      fill_in :password, with: 'billybob'

      click_button 'Login'

      expect(current_path).to eq('/login')
      expect(page).to have_content("Sorry, credentials were invalid. Please try again.")
    end
  end

  describe 'merchant user' do
    it 'employee needs to login with valid credentials' do
      employee = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123", role: 1)
      visit '/login'

      fill_in :email, with: 'test@gmail.com'
      fill_in :password, with: 'password123'

      click_button 'Login'

      expect(current_path).to eq('/merchant/dashboard')
      expect(page).to have_content("#{employee.name}, you have successfully logged in.")
    end

    it 'admin needs to login with valid credentials' do
      admin = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123", role: 2)
      visit '/login'

      fill_in :email, with: 'test@gmail.com'
      fill_in :password, with: 'password123'

      click_button 'Login'

      expect(current_path).to eq('/merchant/dashboard')
      expect(page).to have_content("#{admin.name}, you have successfully logged in.")
    end
  end

  describe 'admin' do
    it 'needs to login with valid credentials' do
      admin = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123", role: 3)
      visit '/login'

      fill_in :email, with: 'test@gmail.com'
      fill_in :password, with: 'password123'

      click_button 'Login'

      expect(current_path).to eq('/admin/dashboard')
      expect(page).to have_content("#{admin.name}, you have successfully logged in.")
    end
  end
end
