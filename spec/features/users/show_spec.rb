require 'rails_helper'

RSpec.describe "User Show Page" do
  describe "As a registered user" do
    it 'has a profile page for a user that shows profile data and a link to edit' do

      user = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'user@user.com',
                          password: 'password')

      visit '/login'

      fill_in :email, with: 'user@user.com'
      fill_in :password, with: 'password'
      click_button 'Login'

      expect(current_path).to eq('/profile')

      within '.user-profile' do
        expect(page).to have_content("Name: #{user.name}")
        expect(page).to have_content("Address: #{user.address}")
        expect(page).to have_content("City: #{user.city}")
        expect(page).to have_content("State: #{user.state}")
        expect(page).to have_content("Zip: #{user.zip}")
        expect(page).to have_content("Email: #{user.email}")
        expect(page).to_not have_content(user.password)
      end
      expect(page).to have_link "Edit Profile"
    end

    it 'has a profile page for a merchant admin/employee that shows profile data and a link to edit' do

      merchant = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'merchant@merchant.com',
                          password: 'password',
                          role: 1)

      visit '/login'

      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password
      click_button 'Login'

      visit '/profile'

      within '.user-profile' do
        expect(page).to have_content("Name: #{merchant.name}")
        expect(page).to have_content("Address: #{merchant.address}")
        expect(page).to have_content("City: #{merchant.city}")
        expect(page).to have_content("State: #{merchant.state}")
        expect(page).to have_content("Zip: #{merchant.zip}")
        expect(page).to have_content("Email: #{merchant.email}")
        expect(page).to_not have_content(merchant.password)
      end
      expect(page).to have_link "Edit Profile"
    end

    it 'has a profile page for an admin that shows profile data and a link to edit' do

      admin = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'admin@admin.com',
                          password: 'password',
                          role: 3)

      visit '/login'

      fill_in :email, with: admin.email
      fill_in :password, with: admin.password
      click_button 'Login'

      visit '/profile'

      within '.user-profile' do
        expect(page).to have_content("Name: #{admin.name}")
        expect(page).to have_content("Address: #{admin.address}")
        expect(page).to have_content("City: #{admin.city}")
        expect(page).to have_content("State: #{admin.state}")
        expect(page).to have_content("Zip: #{admin.zip}")
        expect(page).to have_content("Email: #{admin.email}")
        expect(page).to_not have_content(admin.password)
      end
      expect(page).to have_link "Edit Profile"
    end
  end
end
