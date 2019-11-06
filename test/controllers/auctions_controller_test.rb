require 'test_helper'
require 'date'

class AuctionsControllerTest < ActionDispatch::IntegrationTest
  test '/auctions should retrieve all auctions as json' do
    auctions_to_create = [
      {
        title: 'Mustang',
        description: '1968 Ford Mustang',
        starting_price: 1_200_000,
        ends_at: 10.days.from_now,
      },
      {
        title: 'Fallen Empires Booster',
        description: '3x MTG Fallen Empires booster packs',
        starting_price: 1_000,
        ends_at: 10.days.from_now,
      }
    ]

    auctions_to_create.each { |auction| Auction.create(auction) }

    get '/auctions'
    auction_response = JSON.parse(@response.body, symbolize_names: true)
    response_auction_titles = auction_response.map {|auction| auction[:title]}

    assert_response :success
    assert_equal auctions_to_create.count, auction_response.count
    assert_equal auctions_to_create.map {|auction| auction[:title]}.sort, response_auction_titles.sort
  end

  test 'should return the correct auction given an id' do
    auction_to_create = {
      title: 'Mustang',
      description: '1968 Ford Mustang',
      starting_price: 1_200_000,
      ends_at: 10.days.from_now.strftime('%FT%TZ')
    }
    created_auction = Auction.create(auction_to_create)

    get "/auctions/#{created_auction.id}"
    api_response = JSON.parse(@response.body, symbolize_names: true)

    assert_response :success
    auction_to_create.keys.each do |key|
      if (key == :ends_at)
        assert_equal standardize_time(auction_to_create[key]), standardize_time(api_response[key])
      else
        assert_equal auction_to_create[key], api_response[key]
      end
    end
  end
end
