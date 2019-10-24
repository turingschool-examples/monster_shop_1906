require 'rails_helper'

RSpec.describe 'As a logged in Merchant (employee/admin)' do
  it 'on my dashboard, I see a link to view my own items' do
    user = User.create(
      name: 'Bob',
      address: '123 Main',
      city: 'Denver',
      state: 'CO',
      zip: 80_233,
      email: 'bob@email.com',
      password: 'secure',
      role: 1
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit merchant_dashboard_path

    expect(page).to have_content('View Items')

    click_link 'View Items'

    expect(current_path).to eq(merchant_user_items_path)
  end
end

# As a merchant employee or admin
# When I visit my merchant dashboard
# I see a link to view my own items
# When I click that link
# I should be taken to my merchant's items ("/merchant/items")
