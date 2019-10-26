require 'rails_helper'

describe 'On the merchant dashboard /merchant' do
  describe 'as a merchant employee/admin (above a default user)' do
    it 'has the name and full address of the merchant I work for' do
      merchant_employee = User.create(name: 'Drone', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'employee@employee.com', password: 'password', role: 1 )
      merchant_admin = User.create(name: 'Boss', address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111, email: 'boss@boss.com', password: 'password', role: 2 )
      chester_the_merchant = Merchant.create(name: "Chester's Shop", address: '456 Terrier Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      merchant_user_1 = MerchantUser.create(user_id: merchant_employee.id, merchant_id: chester_the_merchant.id)
      merchant_user_2 = MerchantUser.create(user_id: merchant_admin.id, merchant_id: chester_the_merchant.id)

      users = [merchant_employee, merchant_admin]

      users.each do |user|
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit '/merchant'

        within '.employer-info' do
          expect(page).to have_content(chester_the_merchant.name)
          expect(page).to have_content(chester_the_merchant.address)
          expect(page).to have_content(chester_the_merchant.city)
          expect(page).to have_content(chester_the_merchant.state)
          expect(page).to have_content(chester_the_merchant.zip)
        end
      end
    end
  end
end
