class AuctionsController < ApplicationController
  def index
    auctions = Auction.all_auctions
    render json: auctions
  end

  def show
    auction = Auction.single_auction(params[:id])
    render json: auction
  end
end
