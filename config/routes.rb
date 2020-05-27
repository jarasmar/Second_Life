Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'logout', to: 'sessions#destroy'
  # get 'posts', to: 'posts#all'
  get 'posts/new', to: 'posts#new'
  post 'posts', to: 'posts#create'
  # delete 'posts', to: 'posts#destroy'

  root 'home#index'
end
