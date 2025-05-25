Rails.application.routes.draw do
  root 'home#top'
  get '/users/home', to: 'users#home'
  post 'users/home', to: 'users#home'
  get 'home/about', to: 'home#about'
  
  devise_for :users
  
  resources :books
  resources :users
end
