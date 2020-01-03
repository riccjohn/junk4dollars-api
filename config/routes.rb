Rails.application.routes.draw do
  get 'user/me' => 'secure_users#me'
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
  get 'auctions' => 'auctions#index'
  get 'auctions/:id' => 'auctions#show'
  post 'bid/:id' => 'bids#create'
end
