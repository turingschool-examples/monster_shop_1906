require 'rails_helper'
describe 'Can see name and address of the merchant I work for in the dashboard'  do
  before(:each) do
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @billy = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobill@gmail.com", password: "yours", role: 1,  merchant_id: @bike_shop.id )
    @corina = User.create(name: 'Corina Allen', address: '1488 S. Kenton', city: 'Aurora', state: 'CO', zip:'80014', email: 'StarPerfect@gmail.com', password: 'Hello123', role: 2, merchant_id: @bike_shop.id)
  end

  it 'When a merchant employee logs in ' do
     visit login_path

     fill_in :email, with: 'billobill@gmail.com'
     fill_in :password, with: 'yours'

     click_button 'Login'

    expect(page).to have_content(@bike_shop.name)
    expect(page).to have_content(@bike_shop.address)
    expect(page).to have_content(@bike_shop.city)
    expect(page).to have_content(@bike_shop.state)
    expect(page).to have_content(@bike_shop.zip)

  end

  it 'When a merchant admin logs in ' do
    visit login_path

    fill_in :email, with: 'StarPerfect@gmail.com'
    fill_in :password, with: 'Hello123'

    click_button 'Login'

    expect(page).to have_content(@bike_shop.name)
    expect(page).to have_content(@bike_shop.address)
    expect(page).to have_content(@bike_shop.city)
    expect(page).to have_content(@bike_shop.state)
    expect(page).to have_content(@bike_shop.zip)

  end
end
