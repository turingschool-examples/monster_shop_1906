require 'rails_helper'

# User Story 19, User Profile Show Page
#
# As a registered user
# When I visit my profile page
# Then I see all of my profile data on the page except my password
# And I see a link to edit my profile data

RSpec.describe 'As a registered user' do
  describe 'when I visit my own profile page' do
    it 'shows me all data except password' do
      scott = User.create!(name: 'Scott', email: 'scottbot99@gmail.com', password: 'bot', role: 0,  address: '123 Willow st ', city: 'aurora', state: 'CO', zip: 90210)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(scott)

        visit profile_path

        expect(page).to have_content("Name: #{scott.name}")
        expect(page).to have_content("Email: #{scott.email}")
        expect(page).to have_content("Address: 123 Willow st")
        expect(page).to have_content("City: #{scott.city}")
        expect(page).to have_content("State: #{scott.state}")
        expect(page).to have_content("Zip: #{scott.zip}")
        expect(page).to have_link('Edit Profile')
      end
  end
end
