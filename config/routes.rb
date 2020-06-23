Rails.application.routes.draw do
  resources :profile, :controller => 'users', :as => 'users'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'logout', to: 'sessions#destroy'

  get 'posts', to: 'posts#show'
  # get 'posts/new', to: 'posts#new'
  # post 'posts', to: 'posts#create'
  delete 'posts/:id', to: 'posts#destroy'
  # get 'posts/:id/edit', to: 'posts#edit'
  post 'posts/:id/edit', to: 'posts#update'
  # get 'post/:id', to: 'posts#find'
  resources :posts
  root 'home#index'
end
