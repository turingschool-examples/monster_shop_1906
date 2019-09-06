require 'rails_helper'

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
