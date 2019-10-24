require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'when I click login, I enter my valid email and password' do
    before(:each) do
      visit welcome_path
      click_link 'Log In'
    end

    it 'as a regular user, I am redirected to my profile page' do
      user = User.create(
        name: 'Bob',
        address: '123 Main',
        city: 'Denver',
        state: 'CO',
        zip: 80_233,
        email: 'bob@email.com',
        password: 'secure'
      )

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on 'Sign me in'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome back, #{user.name}!")
      expect(page).to have_link('Log Out')
      expect(page).to_not have_link('Register')
      expect(page).to_not have_link('Log In')
    end

    it 'as a merchant employee or admin, I am redirected to my merchant dashboard' do
      merchant_employee = User.create(
        name: 'Bob',
        address: '123 Main',
        city: 'Denver',
        state: 'CO',
        zip: 80_233,
        email: 'bob@email.com',
        password: 'secure',
        role: 1
      )

      expect(current_path).to eq(login_path)

      fill_in :email, with: merchant_employee.email
      fill_in :password, with: merchant_employee.password

      click_on 'Sign me in'

      expect(current_path).to eq(merchant_dashboard_path)
      expect(page).to have_content("Welcome back, #{merchant_employee.name}!")
      expect(page).to have_link('Log Out')
      expect(page).to_not have_link('Register')
      expect(page).to_not have_link('Log In')
    end

    it 'as a site admin, I am redirected to my site admin dashboard' do
      site_admin = User.create(
        name: 'Bob',
        address: '123 Main',
        city: 'Denver',
        state: 'CO',
        zip: 80_233,
        email: 'bob@email.com',
        password: 'secure',
        role: 3
      )

      expect(current_path).to eq(login_path)

      fill_in :email, with: site_admin.email
      fill_in :password, with: site_admin.password

      click_on 'Sign me in'

      expect(current_path).to eq(admin_path)
      expect(page).to have_content("Welcome back, #{site_admin.name}!")
      expect(page).to have_link('Log Out')
      expect(page).to_not have_link('Register')
      expect(page).to_not have_link('Log In')
    end
  end
end
