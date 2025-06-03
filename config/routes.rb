Rails.application.routes.draw do
  root 'home#top'
  get '/users/home', to: 'users#home'
  post 'users/home', to: 'users#home'
  get 'home/about', to: 'home#about'
  get 'search', to: 'searches#search'
  
  devise_for :users
  
  resources :users do
    member do
      get :followings
      get :followers
    end
  end
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
