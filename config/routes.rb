Rails.application.routes.draw do
  root to: 'homes#top'
  get '/users/home', to: 'users#home'
  post 'users/home', to: 'users#home'
  
  devise_for :users
  
  resources :books
  resources :users
end
