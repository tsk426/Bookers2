Rails.application.routes.draw do
  root 'home#top'
  get '/users/home', to: 'users#home'
  post 'users/home', to: 'users#home'
  get 'home/about', to: 'home#about'
  
  devise_for :users
  
  resources :users
  resources :books do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
end
