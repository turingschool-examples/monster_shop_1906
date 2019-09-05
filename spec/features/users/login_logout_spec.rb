# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in
require 'rails_helper'

RSpec.describe 'Login/Logout Functionality' do
  describe 'when a user visits the login path' do
    before :each do
      @corina = User.create(name: 'Corina Allen', address: '1488 S. Kenton', city: 'Aurora', state: 'CO', zip:, email: 'StarPerfect@gmail.com', password: 'Hello123', role: 2)
      @scott = User.create(name: "Scott Payton", address: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011", email:"bigfun@gmail.com", password: "mine", role: 0 )
      @billy = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobill@gmail.com", password: "yours", role: 1 )
      @kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesome@gmail.com", password: "ours", role: 3)
    end

    it 'valid information redirects to profile path' do
      visit login_path

      fill_in :email, with: 'bigfun@gmail.com'
      fill_in :password, with: 'mine'

      click_on 'Login'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Logged in as #{@scott.name}")
    end

    it 'valid employee login redirects to employee dashboard' do

      fill_in :email, with: 'billobill@gmail.com'
      fill_in :password, with: 'yours'

      click_on 'Login'

      expect(page).to have_link('Merchant Dashboard')
    end

    it 'valid merchant login redirects to merchant dashboard' do

      fill_in :email, with: 'StarPerfect@gmail.com'
      fill_in :password, with: 'Hello123'

      click_on 'Login'

      expect(page).to have_link('Merchant Dashboard')
    end

    it 'valid employee login redirects to admin dashboard' do

      fill_in :email, with: 'kateaswesome@gmail.com'
      fill_in :password, with: 'ours'

      click_on 'Login'

      expect(page).to have_link('Admin Dashboard')
      expect(page).to have_link('Users')
    end
  end
end
