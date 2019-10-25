require 'rails_helper'

RSpec.describe 'As a default user' do
  before :each do
    @user = User.create!(name: "Gmoney", address: "123 Lincoln St", city: "Denver", state: "CO", zip: 23840, email: "test@gmail.com", password: "password123", password_confirmation: "password123")

    visit '/login'

    fill_in :email, with: 'test@gmail.com'
    fill_in :password, with: 'password123'

    click_button 'Login'
  end

  it 'can see all profile data expect password' do
    visit '/profile'

    within '.profile-info' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip)
      expect(page).to have_content(@user.email)
      expect(page).to_not have_content(@user.password)
    end
  end

  it 'can prepopulate form to update profile info' do
    visit '/profile'

    click_link 'Edit Your Info'

    expect(current_path).to eq('/profile/edit')

    expect(page).to have_selector("input[value='Gmoney']")
    expect(page).to have_selector("input[value='123 Lincoln St']")
    expect(page).to have_selector("input[value='Denver']")
    expect(page).to have_selector("input[value='CO']")
    expect(page).to have_selector("input[value='23840']")
    expect(page).to have_selector("input[value='test@gmail.com']")
  end

  it 'can click a button to edit profile data' do
    visit '/profile/edit'

    fill_in :name, with: 'Billy Bob'
    fill_in :address, with: '542 Broadway St'
    fill_in :city, with: 'Topeka'
    fill_in :state, with: 'KS'
    fill_in :zip, with: 54205
    fill_in :email, with: 'billy.bob@gmail.com'

    click_button 'Update Info'

    expect(current_path).to eq('/profile')
    expect(page).to have_content('You have succesfully updated your information!')

    within '.profile-info' do
      expect(page).to have_content('Billy Bob')
      expect(page).to have_content('542 Broadway St')
      expect(page).to have_content('Topeka')
      expect(page).to have_content('KS')
      expect(page).to have_content(54205)
      expect(page).to have_content('billy.bob@gmail.com')
    end
  end
end
