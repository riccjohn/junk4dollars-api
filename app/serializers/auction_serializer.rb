class AuctionSerializer < ActiveModel::Serializer
  has_one :current_bid, key: :bid
  attributes :id, :title, :description, :created_at, :ends_at, :user_id, :starting_price, :current_bid
end
