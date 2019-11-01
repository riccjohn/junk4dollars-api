# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {
    name: 'User 1'
  },
  {
    name: 'User 2'
  }
]

auctions = [
  {
    title: 'Throne of Eldraine Booster Box',
    description: 'New: A brand-new, unused, unopened, undamaged item (including handmade items).',
    start_bid: 85.00,
    current_bid: 88.50,
    end_time: '2019-11-01 15:35:21 -0500'
  },
  {
    title: 'Oko, Theif of Crowns',
    description: 'Brand new. Single card',
    start_bid: 10.00,
    current_bid: 11.50,
    end_time: '2019-11-01 15:35:21 -0500'
  },
]

users.each {|user| User.find_or_create_by(user)}
auctions.each {|auction| Auction.find_or_create_by(auction)}
