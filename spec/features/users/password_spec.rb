# As a registered user
# When I visit my profile page
# I see a link to edit my password
# When I click on the link to edit my password
# I see a form with fields for a new password, and a new password confirmation
# When I fill in the same password in both fields
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my password is updated
require 'rails_helper'

describe "As a Registered user" do
  before(:each) do
    user = User.create(
      name: 'Bob J',
      address: '123 Fake St',
      city: 'Denver',
      state: 'Colorado',
      zip: 80111,
      email: 'user@user.com',
      password: 'password',
    )
    merchant_employee = User.create(
      name: 'Bob J',
      address: '123 Fake St',
      city: 'Denver',
      state: 'Colorado',
      zip: 80111,
      email: 'merchemp@merchemp.com',
      password: 'password',
      role: 1
    )
    merchad = User.create(
      name: 'Bob J',
      address: '123 Fake St',
      city: 'Denver',
      state: 'Colorado',
      zip: 80111,
      email: 'merchad@merchad.com',
      password: 'password',
      role: 2
    )
    admin = User.create(
      name: 'Bob J',
      address: '123 Fake St',
      city: 'Denver',
      state: 'Colorado',
      zip: 80111,
      email: 'admin@admin.com',
      password: 'password',
      role: 3
    )
    @users = [user, merchant_employee, merchad, admin]
  end
  it "displays sad path message for unfilled password info" do
    @users.each do |user|
      visit '/login'
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Login'
      visit '/profile'
      click_link 'Change Password'
      expect(current_path).to eq('/profile/change-password')
      fill_in :password, with: 'password1'
      fill_in :password_confirmation, with: 'pass'
      click_button 'Update Password'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  it "displays sad path message for unfilled password info" do
    @users.each do |user|
      visit '/login'
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Login'
      visit '/profile'
      click_link 'Change Password'
      expect(current_path).to eq('/profile/change-password')
      click_button 'Update Password'
      expect(page).to have_content("Password can't be blank")
    end
  end

  it "updates users password" do
    @users.each do |user|
      visit '/login'
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button 'Login'
      visit '/profile'
      click_link 'Change Password'
      expect(current_path).to eq('/profile/change-password')
      fill_in :password, with: 'password1'
      fill_in :password_confirmation, with: 'password1'
      click_button 'Update Password'
      expect(current_path).to eq('/profile')
      expect(page).to have_content('Your password has been changed.')
    end
  end
end
