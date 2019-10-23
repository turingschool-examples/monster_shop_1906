require 'rails_helper'

describe "As a regular User" do
  describe "When I visit my profile page" do
    before :each do
      @user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end
    
    it "Displays my profile data and a link to edit my profile." do
      visit "/profile/#{@user.id}"

      expect(page).to have_content('Hello, Patti!')
      expect(page).to have_content('953 Sunshine Ave')
      expect(page).to have_content('City: Honolulu')
      expect(page).to have_content('State: Hawaii')
      expect(page).to have_content('Zip Code: 96701')
      expect(page).to have_content('E-mail: pattimonkey34@gmail.com')
      expect(page).to have_link('Edit Profile')
      click_link 'Edit Profile'

      expect(current_path).to eq("/profile/#{@user.id}/edit")
    end
  end
end
