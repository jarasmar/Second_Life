Rails.application.routes.draw do
  resources :profile, :controller => 'users', :as => 'users'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'logout', to: 'sessions#destroy'

  get 'posts', to: 'posts#show'
  delete 'posts/:id', to: 'posts#destroy'
  post 'posts/:id/edit', to: 'posts#update'

  resources :posts
  get 'map', to: 'home#map'
  root 'home#index'
end
