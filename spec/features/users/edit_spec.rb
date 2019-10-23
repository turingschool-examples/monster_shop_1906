require 'rails_helper'

RSpec.describe 'Edit Page' do
  describe 'As a registered user (aka not a visitor)' do
    describe 'As a user (role: 0) when I click edit profile' do
      it 'takes me to a form with my info that I can edit' do
        user = User.create( name: 'Bob J',
                            address: '123 Fake St',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: 80111,
                            email: 'user@user.com',
                            password: 'password')

        visit '/login'

        fill_in :email, with: 'user@user.com'
        fill_in :password, with: 'password'
        click_button 'Login'

        expect(current_path).to eq('/profile')

        click_link 'Edit Profile'

        expect(current_path).to eq('/profile/edit')

        expect(find_field('Name').value).to eq(user.name)
        expect(find_field('Address').value).to eq(user.address)
        expect(find_field('City').value).to eq(user.city)
        expect(find_field('State').value).to eq(user.state)
        expect(find_field('Zip').value).to eq("#{user.zip}")
        expect(find_field('Email').value).to eq(user.email)
        expect(page).to_not have_content 'Password'

        fill_in :address, with: "456 New Address"

        click_button 'Update Information'

        expect(current_path).to eq('/profile')
        expect(page).to have_content('Your profile has been updated')
        expect(page).to have_content('456 New Address')
      end

      it 'takes me to a form with my info that I can edit and does not update
          if incomplete' do
        user = User.create( name: 'Bob J',
                            address: '123 Fake St',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: 80111,
                            email: 'user@user.com',
                            password: 'password')

        visit '/login'

        fill_in :email, with: 'user@user.com'
        fill_in :password, with: 'password'
        click_button 'Login'

        expect(current_path).to eq('/profile')

        click_link 'Edit Profile'

        expect(current_path).to eq('/profile/edit')

        expect(find_field('Name').value).to eq(user.name)
        expect(find_field('Address').value).to eq(user.address)
        expect(find_field('City').value).to eq(user.city)
        expect(find_field('State').value).to eq(user.state)
        expect(find_field('Zip').value).to eq("#{user.zip}")
        expect(find_field('Email').value).to eq(user.email)
        expect(page).to_not have_content 'Password'

        fill_in :address, with: nil

        click_button 'Update Information'

        expect(page).to have_content("Address can't be blank")
      end
    end
  end
end
