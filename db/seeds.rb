# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all
User.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

default_user = User.create(name: "Lynda Ferguson", address: "452 Cherry St", city: "Tucson", state: "AZ", zip: 85736, email: "lferguson@gmail.com", password: "password1", password_confirmation: "password1")
merchant_employee = User.create(name: "Lael Whipple", address: "7392 Oklahoma Ave", city: "Nashville", state: "TN", zip: 37966, email: "whip_whipple@yahoo.com", password: "password12", password_confirmation: "password12", role: 1)
merchant_admin = User.create(name: "Dudley Laughlin", address: "2348 Willow Dr", city: "Big Sky", state: "MT", zip: 59716, email: "bigskyguy@aol.com", password: "password123", password_confirmation: "password123", role: 2)
admin = User.create(name: "Dorian Bouchard", address: "7890 Montreal Blvd", city: "New Orleans", state: "LA", zip: 70032, email: "ouibouchard@gmail.fr", password: "password1234", password_confirmation: "password1234", role:3)
