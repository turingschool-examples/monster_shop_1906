# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a Merchant' do
  it 'employee or admin I see the merchant dashboard' do
    user = User.create(
      password: 'secure', 
      name: 'Bob G', 
      address: '123 Main St.', 
      city: 'Denver', 
      state: 'CO', 
      zip: '80202', 
      email: "bob@gmail.com", 
      role: 1
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit welcome_path

    within 'nav' do
      click_link 'Merchant Dashboard'
    end

    expect(current_path).to eq('/merchant')
  end

  it 'employee or admin I do not have access to site admin dashboard' do
    merchant_employee = User.create(
      password: 'secure', 
      name: 'Bob G', 
      address: '123 Main St.', 
      city: 'Denver', 
      state: 'CO', 
      zip: '80202', 
      email: "bob@gmail.com", 
      role: 1
    )
    merchant_admin = User.create(
      password: 'secure', 
      name: 'Bob G', 
      address: '123 Main St.', 
      city: 'Denver', 
      state: 'CO', 
      zip: '80202', 
      email: "bob@gmail.com", 
      role: 2
    )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

    visit admin_path

    expect(current_path).to eq(admin_path)
    expect(page).to have_content('The page you were looking for doesn\'t exist.')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_admin)

    visit admin_path

    expect(current_path).to eq(admin_path)
    expect(page).to have_content('The page you were looking for doesn\'t exist.')
  end
end
