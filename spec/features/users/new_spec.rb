require 'rails_helper'

describe 'Register' do
  it 'creates a new user' do

    visit '/'

    click_link 'Register'

    expect(current_path).to eq('/register')

    fill_in :name, with: 'Marcel'
    fill_in :address, with: '56 Jungle Lane'
    fill_in :city, with: 'New York'
    fill_in :state, with: 'New York'
    fill_in :zip, with: '10012'
    fill_in :email, with: 'markymonkey23@gmail.com'
    fill_in :password, with: 'bananarama'
    fill_in :password_confirmation, with: 'bananarama'

    click_button 'Complete Registration'

    expect(current_path).to eq('/profile')
    expect(page).to have_content('You have registered successfully! You are now logged in as Marcel.')
    expect(page).to have_content('Hello, Marcel!')
    expect(page).to have_content('Address: 56 Jungle Lane')
    expect(page).to have_content('City: New York')
    expect(page).to have_content('State: New York')
    expect(page).to have_content('Zip Code: 10012')
  end
end
