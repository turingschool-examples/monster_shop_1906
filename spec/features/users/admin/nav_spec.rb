require 'rails_helper'

describe "on the nav bar" do
  describe "as a admin user" do
    it "sees regular user links plus a link to the admin dashboard and users" do

      admin = User.create( name: 'Brian Q',
                              address: '123 Fake St',
                              city: 'Denver',
                              state: 'Colorado',
                              zip: 80111,
                              email: 'admin@admin.com',
                              password: 'password',
                              role: 3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/'

      within '.topnav' do
        expect(page).to have_link('Profile')
        expect(page).to have_link('Logout')
        expect(page).to have_link('Dashboard')
        expect(page).to have_link('Users')
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Cart')
      end

      expect(page).to have_content("Logged in as #{admin.name}")
    end
  end
end