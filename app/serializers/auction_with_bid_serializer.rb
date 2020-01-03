class AuctionWithBidSerializer
  def self.serialize(auction_with_bid)
    auction = auction_with_bid.auction.attributes

    if auction_with_bid.bid
      auction.merge(bid: auction_with_bid.bid.attributes)
    else
      auction
    end
  end
end
