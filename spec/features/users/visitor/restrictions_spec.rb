require 'rails_helper'

# As a Visitor
# When I try to access any path that begins with the following, then I see a 404 error:
# - '/merchant'
# - '/admin'
# - '/profile'

RSpec.describe "Visitor Restrictions" do
  it 'visitor cannot visit merchant dashboard' do
    visit "/merchant"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  it 'visitor cannot visit admin dashboard' do
    visit "/admin"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  it 'visitor cannot visit a user profile' do
    visit "/profile"

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
