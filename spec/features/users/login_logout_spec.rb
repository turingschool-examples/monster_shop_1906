require 'rails_helper'

RSpec.describe 'Login/Logout Functionality' do
  describe 'when a user visits the login path' do
    before :each do
      @scott = User.create(name: "Scott Payton", address: "123 Scott Street", city: "Stapleton", state: "CO", zip: "80011", email:"bigfun@gmail.com", password: "mine", role: 0 )
      @billy = User.create(name: "Billy Joel", address: "123 Billy Street", city: "Denver", state: "CO", zip: "80011", email:"billobill@gmail.com", password: "yours", role: 1 )
      @corina = User.create(name: 'Corina Allen', address: '1488 S. Kenton', city: 'Aurora', state: 'CO', zip: '80014', email: 'StarPerfect@gmail.com', password: 'Hello123', role: 2)
      @kate = User.create(name: "Kate Long", address: "123 Kate Street", city: "Fort Collins", state: "CO", zip: "80011", email:"kateaswesome@gmail.com", password: "ours", role: 3)
    end

    it 'valid information redirects to profile path' do
      visit login_path

      fill_in :email, with: 'bigfun@gmail.com'
      fill_in :password, with: 'mine'

      click_button 'Login'

      expect(page).to_not have_content("This is a employee user profile page")
      expect(page).to_not have_content("This is a merchant user profile page")
      expect(page).to_not have_content("This is a admin user profile page")
      expect(page).to have_content("This is a regular user profile page")
    end

    it 'valid employee login redirects to employee dashboard' do
      visit login_path

      fill_in :email, with: 'billobill@gmail.com'
      fill_in :password, with: 'yours'

      click_button 'Login'

      expect(page).to have_content("This is a employee user profile page")
      expect(page).to_not have_content("This is a merchant user profile page")
      expect(page).to_not have_content("This is a admin user profile page")
      expect(page).to_not have_content("This is a regular user profile page")
    end

    it 'valid merchant login redirects to merchant dashboard' do
      visit login_path

      fill_in :email, with: 'StarPerfect@gmail.com'
      fill_in :password, with: 'Hello123'

      click_button 'Login'

      expect(page).to_not have_content("This is a employee user profile page")
      expect(page).to have_content("This is a merchant user profile page")
      expect(page).to_not have_content("This is a admin user profile page")
      expect(page).to_not have_content("This is a regular user profile page")
    end

    it 'valid employee login redirects to admin dashboard' do
      visit login_path

      fill_in :email, with: 'kateaswesome@gmail.com'
      fill_in :password, with: 'ours'

      click_button 'Login'

      expect(page).to_not have_content("This is a employee user profile page")
      expect(page).to_not have_content("This is a merchant user profile page")
      expect(page).to have_content("This is a admin user profile page")
      expect(page).to_not have_content("This is a regular user profile page")
    end
  end

  describe 'When submitting invalid credentials' do
    it 'displays flash message telling users either credential is incorrect but not which one' do

      visit login_path

      fill_in :email, with: '12345@gmail.com'
      fill_in :password, with: 'incorrect password'

      click_button 'Login'

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Invalid Credentials, please try again.")
    end
  end

  describe "A user can logout" do
    it "Logs user out" do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      user = User.create(name:"Santiago", address:"123 tree st", city:"lakewood", state:"CO", zip: "19283",password: "yes", email:"santamonica@hotmail.com", role:0)

      visit login_path

      fill_in :email, with: "santamonica@hotmail.com"
      fill_in :password, with: 'yes'

      click_button 'Login'

      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"

      expect(page).to have_content("Logout")

      click_on "Logout"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("You have been logged out!")
      expect(page).to_not have_content("Logged in as")

      visit '/cart'
      expect(page).to have_content("Cart is currently empty")

    end
  end
end
