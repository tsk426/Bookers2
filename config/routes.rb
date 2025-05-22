Rails.application.routes.draw do
  root to: 'homes#top'
  get '/users/home', to: 'users#home'
  post 'users/home', to: 'users#home'
  get 'homes/about', to: 'homes#about'
  
  devise_for :users
  
  resources :books
  resources :users
end
