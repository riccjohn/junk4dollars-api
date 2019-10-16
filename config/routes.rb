Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :users
  get 'users' => 'users#index'
  get 'users/:id' => 'users#show'
end
