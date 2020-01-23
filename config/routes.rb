Rails.application.routes.draw do
  get 'user/me' => 'secure_users#me'
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
  get 'auctions' => 'auctions#index'
  get 'auctions/all/details' => 'auctions#show_detail'
  get 'auctions/:id' => 'auctions#show'
  post 'auctions/:auction_id/bid' => 'bids#create'
end
