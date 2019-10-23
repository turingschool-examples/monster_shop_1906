# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in

describe "As a visitor" do

  it "cant login with nad credentials" do
    user = User.create( name: 'Bob J',
                        address: '123 Fake St',
                        city: 'Denver',
                        state: 'Colorado',
                        zip: 80111,
                        email: 'user@user.com',
                        password: 'password')

    visit '/login'

    fill_in :email, with: 'us@user.com'
    fill_in :password, with: 'password'
    click_button 'Login'
    expect(page).to have_content("Sorry your credentials are bad.")

    fill_in :email, with: 'user@user.com'
    fill_in :password, with: 'pas'
    click_button 'Login'
    expect(page).to have_content("Sorry your credentials are bad.")
  end

  it "can login and redirect to user profile page" do
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

    expect(current_path).to eq('/profile')
    expect(page).to have_content("Logged in as #{user.name}")
  end

  it "can login and redirect to merchant dashboard page" do
    merchant = User.create( name: 'Bill J',
                        address: '123 Fake St',
                        city: 'Denver',
                        state: 'Colorado',
                        zip: 80111,
                        email: 'merchant@merchant.com',
                        password: 'password',
                        role: 2)

    visit '/login'

    fill_in :email, with: 'merchant@merchant.com'
    fill_in :password, with: 'password'
    click_button 'Login'

    expect(current_path).to eq('/merchant')
    expect(page).to have_content("Logged in as #{merchant.name}")
  end

  it "can login and redirect to admin dashboard page" do
    admin = User.create( name: 'Nick J',
                        address: '123 Fake St',
                        city: 'Denver',
                        state: 'Colorado',
                        zip: 80111,
                        email: 'admin@admin.com',
                        password: 'password',
                        role: 3)

    visit '/login'

    fill_in :email, with: 'admin@admin.com'
    fill_in :password, with: 'password'
    click_button 'Login'
    expect(current_path).to eq('/admin')
    expect(page).to have_content("Logged in as #{admin.name}")
  end
end
