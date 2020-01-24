Rails.application.routes.draw do
  get 'user/me' => 'secure_users#me'
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
  get 'users/top/:count' => 'users#top'
  get 'auctions' => 'auctions#index'
  get 'auctions/all/details' => 'auctions#show_detail'
  get 'auctions/:id' => 'auctions#show'
  get 'auctions/bids/count' => 'auctions#bid_count'
  post 'auctions/:auction_id/bid' => 'bids#create'
end
