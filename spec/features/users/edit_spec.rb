require 'rails_helper'

RSpec.describe 'Edit Page' do
  describe 'As a registered user (aka not a visitor)' do
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

    it 'takes me to a form with my info that I can edit' do
      @users.each do |user|
        visit '/login'

        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button 'Login'

        visit '/profile'
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
    end

    it 'takes me to a form with my info that I can edit and does not update
        if incomplete' do
      @users.each do |user|
        visit '/login'

        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button 'Login'

        visit '/profile'

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

    it 'a user cannot edit their email to another user email' do
      @users.each_with_index do |user, index|
        visit '/login'

        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button 'Login'

        visit '/profile'

        click_link 'Edit Profile'

        expect(current_path).to eq('/profile/edit')

        expect(find_field('Name').value).to eq(user.name)
        expect(find_field('Address').value).to eq(user.address)
        expect(find_field('City').value).to eq(user.city)
        expect(find_field('State').value).to eq(user.state)
        expect(find_field('Zip').value).to eq("#{user.zip}")
        expect(find_field('Email').value).to eq(user.email)
        expect(page).to_not have_content 'Password'

        fill_in :email, with: @users[index-1].email
        click_button 'Update Information'

        expect(page).to have_content("Email has already been taken")
      end
    end
  end
end
