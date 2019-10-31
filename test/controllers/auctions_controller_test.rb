require 'test_helper'
require 'date'

class AuctionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get /auctions endpoint' do
    get '/auctions'
    assert_response :success
  end

  test '/auctions should retrieve all auctions as json' do
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

    get '/auctions'
    auction_response = JSON.parse(@response.body, symbolize_names: true)
    response_auction_titles = auction_response.map {|auction| auction[:title]}
    assert_equal auctions_to_create.count, auction_response.count
    assert_equal auctions_to_create.map {|auction| auction[:title]}.sort, response_auction_titles.sort
  end

  test 'should get /auctions/1 endpoint' do
    created_auction = Auction.create(
      title: 'Mustang',
      description: '1968 Ford Mustang',
      start_bid: 12000.00,
      current_bid: 12000.00,
      end_time: DateTime.now + 10
    )
    get "/auctions/#{created_auction.id}"
    assert_response :success
  end

  test 'should return the correct auction given an id' do
    auction_to_create = {
      title: 'Mustang',
      description: '1968 Ford Mustang',
      start_bid: 12000.00,
      current_bid: 12000.00,
      end_time: 10.days.from_now.strftime('%FT%TZ')
    }
    created_auction = Auction.create(auction_to_create)

    get "/auctions/#{created_auction.id}"
    api_response = JSON.parse(@response.body, symbolize_names: true)

    auction_to_create.keys.each do |key|
      if (key == :end_time)
        assert_equal standardize_time(auction_to_create[key]), standardize_time(api_response[key])
      else
        assert_equal auction_to_create[key].to_s, api_response[key]
      end
    end
  end
end
