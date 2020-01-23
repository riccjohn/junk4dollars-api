class AuctionsController < ApplicationController
  def index
    auctions = Auction.all
    render json: auctions
  end

  def show
    auction = Auction.find(params[:id])
    render json: auction
  end

  def show_detail

    sql = "SELECT
    auctions.id AS auction_id,
    auctions.title,
    auctions.created_at AS auction_created_at,
    COALESCE(bids.price, auctions.starting_price) AS price,
    seller.name AS seller_name,
    bidder.name AS bidder_name
    FROM auctions
      LEFT JOIN (
        SELECT auction_id, MAX(created_at) AS created_at FROM bids GROUP BY auction_id
      ) high_bid ON auctions.id=high_bid.auction_id
    LEFT JOIN bids ON bids.auction_id=auctions.id AND bids.created_at=high_bid.created_at
    JOIN users seller ON auctions.user_id=seller.id
    LEFT JOIN users bidder ON bids.id=bidder.id
    ORDER BY auctions.id
    "

    @result = ActiveRecord::Base.connection.execute(sql)
    render json: @result
  end
end
