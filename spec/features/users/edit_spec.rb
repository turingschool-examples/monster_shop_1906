require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'when I visit the edit profile data form' do
    before :each do
      @user = User.create(
        name: 'Bob', 
        address: '123 Main', 
        city: 'Denver', 
        state: 'CO', 
        zip: 80_233, 
        email: 'bob@email.com',
        password: 'secure'
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path

      within '#user-info' do
        click_link 'Edit Profile'
      end
    end

    it 'is prepopulated with my previous data' do
      expect(find_field(:name).value).to eq(@user.name)
      expect(find_field(:address).value).to eq(@user.address)
      expect(find_field(:city).value).to eq(@user.city)
      expect(find_field(:state).value).to eq(@user.state)
      expect(find_field(:zip).value).to eq(@user.zip)
      expect(find_field(:email).value).to eq(@user.email)
    end

    it 'edited data shows on the profile page' do
      fill_in :name, with: 'Bob'
      fill_in :address, with: '542 Oak Ave'
      fill_in :city, with: 'Boulder'
      fill_in :state, with: 'Colorado'
      fill_in :zip, with: 80_001
      fill_in :email, with: 'bob@email.com'

      click_button 'Update Profile'

      expect(current_path).to eq(profile_path)

      expect(page).to have_content('Your profile data has been updated!')
      
      within '#user-info' do
        expect(page).to have_content('Bob')
        expect(page).to have_content('542 Oak Ave')
        expect(page).to have_content('Boulder')
        expect(page).to have_content('Colorado')
        expect(page).to have_content('80001')
        expect(page).to have_content('bob@email.com')
      end
    end
  end
end