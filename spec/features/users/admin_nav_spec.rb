# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As an admin' do
  it 'has a link to the admin dashboard' do
    admin = User.create(username: 'funbucket14', password: 'secure', role: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/'

    within 'nav' do
      click_link 'Admin Dashboard'
    end

    expect(current_path).to eq('/admin')

    within 'nav' do
      click_link 'Users'
    end

    expect(current_path).to eq('/admin/users')

    within 'nav' do
      expect(page).to_not have_link('Cart')
    end
  end
end
