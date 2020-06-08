Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'logout', to: 'sessions#destroy'

  # get 'posts', to: 'posts#show'
  get 'posts/new', to: 'posts#new'
  post 'posts', to: 'posts#create'
  delete 'posts', to: 'posts#destroy'
  get 'posts/edit', to: 'posts#edit'
  post 'posts/edit', to: 'posts#update'

  root 'home#index'
end
