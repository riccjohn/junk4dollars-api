class AuctionSerializer < ActiveModel::Serializer
  has_one :bid
  attributes :id, :title, :description, :created_at, :ends_at, :user_id, :starting_price, :bid
end
