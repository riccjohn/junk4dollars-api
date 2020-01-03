class AuctionWithBid
  extend ActiveModel::Naming
  include ActiveModel::Serialization

  attr_reader :auction, :bid

  def initialize(auction, bid)
    @auction = auction
    @bid = bid
  end
end
