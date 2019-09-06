require 'rails_helper'
RSpec.describe 'As a registered user' do
  describe 'when I visit my own profile page' do
    it 'shows me all data except password' do
      scott = User.create!(name: 'Scott', email: 'scottbot99@gmail.com', password: 'bot', role: 0,  address: '123 Willow st ', city: 'aurora', state: 'CO', zip: 90210)

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
