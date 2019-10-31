require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  test 'all_auctions returns an array of auctions' do
    auctions_to_create = [
      {
        title: 'Mustang',
        description: '1968 Ford Mustang',
        start_bid: 12000.00,
        current_bid: 12000.00,
        end_time: 10.days.from_now,
      },
      {
        title: 'Fallen Empires Booster',
        description: '3x MTG Fallen Empires booster packs',
        start_bid: 10.00,
        current_bid: 14.50,
        end_time: 10.days.from_now,
      }
    ]

    auctions_to_create.each do |auction| Auction.create(
        title: auction[:title],
        description: auction[:description],
        start_bid: auction[:start_bid],
        current_bid: auction[:current_bid],
        end_time: auction[:end_time]
      ) end

    returned_auctions = Auction.all_auctions
    assert_equal 2, returned_auctions.length
    assert_equal auctions_to_create.map {|auction| auction[:title]}, returned_auctions.map {|auction| auction[:title]}
  end

  test 'single_auction returns an auction given an id' do
    auction_to_create = {
      title: 'Throne of Eldraine Booster Box',
      description: '36 Booster Packs for MTG: Throne of Eldraine',
      start_bid: 80.00,
      current_bid: 98.50,
      end_time: 5.days.from_now,
    }

    created_auction = Auction.create(auction_to_create)
    returned_auction = Auction.single_auction(created_auction.id)
    assert_equal returned_auction[:title], created_auction[:title]
  end
end
