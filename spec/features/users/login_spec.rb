require 'rails_helper'


describe 'Login' do
  it 'can log in with valid credendtials' do
    user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', e_mail: 'pattimonkey34@gmail.com', password: 'banana')

    visit '/'

    click_link 'Login'


    fill_in :e_mail, with: user.e_mail
    fill_in :password, with: user.password
    click_button 'Log In'

    expect(current_path).to eq('/profile')
    expect(page).to have_content('Welcome, Patti!')
    expect(page).to have_content('Address: 953 Sunshine Ave')
    expect(page).to have_content('City: Honolulu')
    expect(page).to have_content('State: Hawaii')
    expect(page).to have_content('Zip Code: 96701')
    expect(page).to have_content('E-mail: pattimonkey34@gmail.com')

  end
end
