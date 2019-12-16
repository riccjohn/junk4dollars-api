Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'user/me' => 'secure_users#me'
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
  get 'auctions' => 'auctions#index'
  get 'auctions/:id' => 'auctions#show'
end
