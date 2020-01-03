class AuctionsController < ApplicationController
  def index
    auctions = Auction.all
    render json: auctions
  end

  def show
    auction = Auction.find(params[:id])

    bid = auction.bids.order(:created_at).last

    auction_with_bid = AuctionWithBid.new(auction, bid)
    render json: AuctionWithBidSerializer.serialize(auction_with_bid)
  end
end
