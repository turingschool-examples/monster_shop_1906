require 'rails_helper'


describe 'Login' do
  describe "as a User" do
    before(:each) do
      @user = User.create(name: 'Patti', address: '953 Sunshine Ave', city: 'Honolulu', state: 'Hawaii', zip: '96701', email: 'pattimonkey34@gmail.com', password: 'banana')
    end
    it 'can log in with valid credentials' do

      visit '/'

      click_link 'Login'

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button 'Log In'

      expect(current_path).to eq("/profile/#{@user.id}")
      expect(page).to have_content('Welcome, Patti! You are logged in.')
      expect(page).to have_content('Address: 953 Sunshine Ave')
      expect(page).to have_content('City: Honolulu')
      expect(page).to have_content('State: Hawaii')
      expect(page).to have_content('Zip Code: 96701')
      expect(page).to have_content('E-mail: pattimonkey34@gmail.com')
    end
    
    it 'cannot log in with invalid credentials' do

      visit '/'

      click_link 'Login'

      fill_in :email, with: @user.email
      fill_in :password, with: 'monkeyingaround'
      click_button 'Log In'

      expect(current_path).to eq('/login')
      expect(page).to have_content('Credentials were incorrect.')
    end
    it 'redirects to profile if I am already logged in' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/login'

      expect(current_path).to eq("/profile/#{@user.id}")
      expect(page).to have_content('You are already logged in.')
    end
  end

  describe "as a Merchant User" do
    before(:each) do
      @merchant_user = User.create!(name: 'Leslie', address: '252 Pawnee Avenue', city: 'Pawnee', state: 'Indiana', zip: '80503', email: 'leslieknope@gmail.com', password: 'waffles', role: 1)
    end
    it "can login with valid credentials" do

      visit '/'

      click_link 'Login'

      fill_in :email, with: @merchant_user.email
      fill_in :password, with: @merchant_user.password
      click_button 'Log In'

      expect(current_path).to eq("/merchant/#{@merchant_user.id}")
      expect(page).to have_content('Welcome, Leslie! You are logged in.')
      expect(page).to have_content('Address: 252 Pawnee Avenue')
      expect(page).to have_content('City: Pawnee')
      expect(page).to have_content('State: Indiana')
      expect(page).to have_content('Zip Code: 80503')
      expect(page).to have_content('E-mail: leslieknope@gmail.com')
    end
    it 'redirects to merchant dashboard if I am already logged in' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

      visit '/login'

      expect(current_path).to eq("/merchant/#{@merchant_user.id}")
      expect(page).to have_content('You are already logged in.')
    end
  end

  describe "as an Admin User" do
    before(:each) do
      @admin_user = User.create!(name: 'Sabrina', address: '66 Witches Way', city: 'Greendale', state: 'West Virginia', zip: '26210', email: 'spellcaster23@gmail.com', password: 'salem', role: 3)
    end
    it "can login with valid credentials" do

      visit '/'

      click_link 'Login'

      fill_in :email, with: @admin_user.email
      fill_in :password, with: @admin_user.password
      click_button 'Log In'

      expect(current_path).to eq("/admin/#{@admin_user.id}")
      expect(page).to have_content('Welcome, Sabrina! You are logged in.')
      expect(page).to have_content('Address: 66 Witches Way')
      expect(page).to have_content('City: Greendale')
      expect(page).to have_content('State: West Virginia')
      expect(page).to have_content('Zip Code: 26210')
      expect(page).to have_content('E-mail: spellcaster23@gmail.com')
    end
    it 'redirects to merchant dashboard if I am already logged in' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

      visit '/login'

      expect(current_path).to eq("/admin/#{@admin_user.id}")
      expect(page).to have_content('You are already logged in.')
    end
  end

end
