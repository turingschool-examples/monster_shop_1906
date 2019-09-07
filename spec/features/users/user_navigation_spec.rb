require 'rails_helper'

RSpec.describe 'User Navigation' do
  describe 'As a registered regular user' do
    it 'I see the same links as a visitor plus a link to my profile and logout' do
      user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283", email:"santamonica@hotmail.com", role:0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/merchants'

      within 'nav' do
        expect(page).to have_link("Logout")
        expect(page).to have_link("Profile")
      end
    end
  end
end
# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"
RSpec.describe 'Users Order Show Page' do
  describe 'when a logged in user has placed orders' do
    it 'can click My Orders profile page link to see all their orders' do
      user = User.create(name: 'Corina', address: '789 Hungry Way', city: 'Denver', state: 'Colorado', zip: '80205', email: 'StarPerfect@gmail.com', password: 'Hello123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_path

      click_link 'My Orders'

      expect(current_path).to eq(user_orders_path)
    end
  end
end
