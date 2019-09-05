# As a visitor
# When I click on the 'register' link in the nav bar
# Then I am on the user registration page ('/register')
# And I see a form where I input the following data:
# - my name
# - my street address
# - my city
# - my state
# - my zip code
# - my email address
# - my preferred password
# - a confirmation field for my password
#
# When I fill in this form completely,
# And with a unique email address not already in the system
# My details are saved in the database
# Then I am logged in as a registered user
# I am taken to my profile page ("/profile")
# I see a flash message indicating that I am now registered and logged in
require 'rails_helper'

RSpec.describe 'As a visitor I see a link to register on the nav bar' do
  it 'can click register and sign up as a user' do
    visit '/register'

    fill_in :name, with: 'Corina Allen'
    fill_in :address, with: '1488 S Kenton St'
    fill_in :city, with: 'Aurora'
    fill_in :state, with: 'CO'
    fill_in :zip, with: '80012'
    fill_in :email, with: 'StarPerfect@gmail.com'
    fill_in :password, with: 'Hello123'
    fill_in :confirm, with: 'Hello123'

    click_button 'Save Me'

    user = User.last

    expect(current_path).to eq(profile_path(user))
    expect(page).to have_content('You are now a registered user and have been logged in.')
  end
end
