# User Story 20, User Can Edit their Profile Data
#
# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# I see a form like the registration page
# The form is prepopulated with all my current information except my password
# When I change any or all of that information
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information

require 'rails_helper'

RSpec.describe 'Visitor' do
  describe 'User can see the registration page form for their data' do
    before :each do
      @scott = User.create!(name: "scott payton", address: "222 willow st", city: "aurora", state: "CO", zip: 99999, email: "hero@gmail.com", password: "blue")
      @kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesome@gmail.com", password: "ours", role:2 )

    end

    it 'The form is prepopulated with current info except password' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@scott)

      visit profile_path #"/users/#{@scott.id}"

      click_link "Edit Profile"

      fill_in "Name", with: "scott payton"
      fill_in "Address", with: "222 willows st"
      fill_in "City", with: "aurora"
      fill_in "State", with: "LOLOLOL"
      fill_in "Zip", with: 99999
      fill_in "Email", with: "hero@gmail.com"

      click_button "Update Profile"
      @scott.reload
      expect(current_path).to eq(profile_path)#("/users/#{@scott.id}")
      expect(page).to have_content(@scott.name)
      expect(page).to have_content(@scott.address)
      expect(page).to have_content(@scott.city)
      # expect(page).to have_content("LOLOLOL")
      expect(@scott.state).to eq("LOLOLOL")
      expect(@scott.zip).to eq("99999")
      expect(page).to have_content(@scott.email)
    end

    it 'I can update my password' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@scott)


      visit profile_path

      expect(page).to have_link("Edit Password")

      click_link "Edit Password"

      expect(current_path).to eq('/profile/edit_password')


      fill_in "Password", with: 'pass'
      fill_in "Password confirmation", with: 'pass'

      click_button "Update Password"

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Your password is updated!')
    end

  end
end
