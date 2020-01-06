class AuctionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :ends_at, :user_id, :starting_price, :bid
end
