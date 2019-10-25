require 'rails_helper'

RSpec.describe "User Show Page (/profile)" do
  describe "As a registered user" do
    before(:each) do

      @user = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'user@user.com',
                          password: 'password')

      @merchant = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'merchant@merchant.com',
                          password: 'password',
                          role: 1)


      @admin = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'admin@admin.com',
                          password: 'password',
                          role: 3)


    end
    it 'has a profile page for a user that shows profile data and a link to edit' do


      visit '/login'

      fill_in :email, with: 'user@user.com'
      fill_in :password, with: 'password'
      click_button 'Login'

      expect(current_path).to eq('/profile')

      within '.user-profile' do
        expect(page).to have_content("Name: #{@user.name}")
        expect(page).to have_content("Address: #{@user.address}")
        expect(page).to have_content("City: #{@user.city}")
        expect(page).to have_content("State: #{@user.state}")
        expect(page).to have_content("Zip: #{@user.zip}")
        expect(page).to have_content("Email: #{@user.email}")
        expect(page).to_not have_content(@user.password)
      end
      expect(page).to have_link "Edit Profile"
    end

    it 'has a profile page for a merchant admin/employee that shows profile data and a link to edit' do
      visit '/login'

      fill_in :email, with: @merchant.email
      fill_in :password, with: @merchant.password
      click_button 'Login'

      visit '/profile'

      within '.user-profile' do
        expect(page).to have_content("Name: #{@merchant.name}")
        expect(page).to have_content("Address: #{@merchant.address}")
        expect(page).to have_content("City: #{@merchant.city}")
        expect(page).to have_content("State: #{@merchant.state}")
        expect(page).to have_content("Zip: #{@merchant.zip}")
        expect(page).to have_content("Email: #{@merchant.email}")
        expect(page).to_not have_content(@merchant.password)
      end
      expect(page).to have_link "Edit Profile"
    end

    it 'has a profile page for an admin that shows profile data and a link to edit' do
      visit '/login'

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_button 'Login'

      visit '/profile'

      within '.user-profile' do
        expect(page).to have_content("Name: #{@admin.name}")
        expect(page).to have_content("Address: #{@admin.address}")
        expect(page).to have_content("City: #{@admin.city}")
        expect(page).to have_content("State: #{@admin.state}")
        expect(page).to have_content("Zip: #{@admin.zip}")
        expect(page).to have_content("Email: #{@admin.email}")
        expect(page).to_not have_content(@admin.password)
      end
      expect(page).to have_link "Edit Profile"
    end

    it 'a registered user has a link to view their orders' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/profile'

      expect(page).to_not have_link('My Orders')

      order = @user.orders.create!(name: @user.name, address: @user.address, city: @user.city, state: @user.state, zip: @user.zip)

      visit '/profile'
      click_link 'My Orders'

      expect(current_path).to eq('/profile/orders')
    end
  end
end
