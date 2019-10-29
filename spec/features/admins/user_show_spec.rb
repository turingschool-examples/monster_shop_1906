require 'rails_helper'

RSpec.describe 'Admin User Show Page', type: :feature do
  it 'shows all user info but no edit link' do
    user = User.create!(name: "Andy Dwyer", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password", password_confirmation: "password")
    admin = User.create!(name: "Ron Swanson", address: "789 Washington Blvd", city: "New Orleans", state: "LA", zip: 70010, email: "test@aol.com", password: "password", password_confirmation: "password", role: 3)

    visit '/login'

    fill_in :email, with: 'test@aol.com'
    fill_in :password, with: 'password'

    click_button 'Login'

    visit "/admin/users/#{user.id}"

    within '.profile-info' do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.address)
      expect(page).to have_content(user.city)
      expect(page).to have_content(user.state)
      expect(page).to have_content(user.zip)
      expect(page).to have_content(user.email)
    end

    expect(page).to_not have_link('Edit Your Info')
    expect(page).to_not have_link('Change Your Password')
  end
end
