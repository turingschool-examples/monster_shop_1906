require 'rails_helper'

describe "as a visitor" do
  describe "when I visit a path I am not supposed to access" do
    it "sees an 404 error" do

      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'

      expect(page).to have_content("The page you were looking for doesn't exist.")

    end
  end
end