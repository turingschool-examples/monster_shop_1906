require 'rails_helper'

describe "as a merchant user" do
  describe "when I visit a path I am not supposed to access" do
    it "sees an 404 error" do

      admin = User.create!(
        name: 'Bob J',
        address: '123 Fake St',
        city: 'Denver',
        state: 'Colorado',
        zip: 80111,
        email: 'admin@admin.com',
        password: 'password',
        role: 3
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/cart'

      expect(page).to have_content("The page you were looking for doesn't exist.")

    end
  end
end
