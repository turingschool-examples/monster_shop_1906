require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'as a Registered User' do
    it "has profile and logout links but doesn't have login or register links" do
      user = User.create(username: 'funbucket12', password: 'secure')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      within 'nav' do
        expect(page).to have_content('Logged in as:')

        click_link 'funbucket12'
      end

      expect(current_path).to eq('/profile')

      within 'nav' do
        expect(page).to_not have_link('Register')
        expect(page).to_not have_link('Log In')
      end

      within 'nav' do
        click_link 'Log Out'
      end

      expect(current_path).to eq('/logout')
    end
  end
end
