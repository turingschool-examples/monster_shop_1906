require 'rails_helper'

describe 'As a registered user, merchant, or admin' do
  describe 'When i click logout' do
    it 'logs me out and removes the items in my cart' do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      user = User.create( name: 'Bob J',
                          address: '123 Fake St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: 80111,
                          email: 'user@user.com',
                          password: 'password')

      visit '/login'

      fill_in :email, with: 'user@user.com'
      fill_in :password, with: 'password'
      click_button 'Login'

      visit "/items/#{paper.id}"
      click_on "Add To Cart"
      visit "/items/#{tire.id}"
      click_on "Add To Cart"
      visit "/items/#{pencil.id}"
      click_on "Add To Cart"

      within '.topnav' do
        expect(page).to have_link('Cart: 3')
      end

      click_link 'Logout'

      expect(current_path).to eq('/')
      within '.topnav' do
        expect(page).to have_link('Login')
        expect(page).to have_link('Register')
        expect(page).to have_link('Cart: 0')
        expect(page).to_not have_link('Profile')
        expect(page).to_not have_link('Logout')
      end
      expect(page).to have_content("You have logged out.")
    end
  end
end
