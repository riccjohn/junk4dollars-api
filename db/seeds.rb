user_data = [
  {
    name: 'John Riccardi',
    auth0_id: 'auth0|5ddc4e5801825f0f008cf4c5'
  },
  {
    name: 'Polly Jones',
    auth0_id: 'auth0|000000000000000000000000'
  },
  {
    name: 'Quinn',
    auth0_id: 'auth0|000000000000000000000001'
  },
  {
    name: 'John 8thLight',
    auth0_id: 'google-oauth2|102216267915836354807'
  }
]

users = user_data.map {|user| User.find_or_create_by(user)}

auction_data = [
  {
    title: 'Throne of Eldraine Booster Box',
    description: 'New: A brand-new, unused, unopened, undamaged item (including handmade items).',
    starting_price: 8500,
    ends_at: '2019-11-01 15:35:21 -0500',
    user_id: users[0].id
  },
  {
    title: 'Oko, Theif of Crowns',
    description: 'Brand new. Single card',
    starting_price: 1000,
    ends_at: '2019-11-01 15:35:21 -0500',
    user_id: users[0].id
  },
  {
    title: 'Garruk, Cursed Huntsman',
    description: 'Throne of Eldraine | Mythic Rare | Regular Card (non-foil)',
    starting_price: 449,
    ends_at: '2020-01-03 16:00:00 -0500',
    user_id: users[0].id
  },
  {
    title: 'MTG Throne of Eldraine Brawl Decks (4)',
    description: 'Set of all 4 ToE Brawl Decks',
    starting_price: 7000,
    ends_at: '2020-01-05 16:00:00 -0500',
    user_id: users[0].id
  },
  {
    title: 'Theros Beyond Death Booster Box',
    description: 'New: A brand-new, unused, unopened, undamaged item (including handmade items).',
    starting_price: 9499,
    ends_at: '2020-01-24 00:00:00 -0500',
    user_id: users[0].id
  },
  {
    title: 'Lenovo ThinkPad X220',
    description: 'Lenovo ThinkPad X220 Laptop i5-2410M 2.30GHz 4GB 500GB Win10Pro wifi',
    starting_price: 7500,
    ends_at: '2020-01-05 12:30:30 -0500',
    user_id: users[2].id
  },
  {
    title: 'ThinkPad T480 | i7-8650U | 512 GB SSD | 16 GB DDR4 RAM',
    description: 'Item is in used condition and shows some wear and tear on the chassis and LCD. Laptop only, no power adapter.',
    starting_price: 20000,
    ends_at: '2020-01-06 14:00:00 -0500',
    user_id: users[2].id
  },
]

auctions = auction_data.map {|auction| Auction.find_or_create_by(auction)}

bid_data = [
  {auction_id: auctions[0].id, price: 8599, user_id: users[1].id},
  {auction_id: auctions[5].id, price: 7599, user_id: users[0].id},
  {auction_id: auctions[0].id, price: 8699, user_id: users[2].id}
]

bids = bid_data.each {|bid| Bid.find_or_create_by(bid)}
