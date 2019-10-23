require 'rails_helper'

RSpec.describe 'As a Merchant' do
  it 'employee or admin I see the merchant dashboard' do
    user = User.create(username: 'funbucket13', password: 'secure', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    within 'nav' do
      click_link 'Merchant Dashboard'
    end

    expect(current_path).to eq('/merchant')
  end
end
