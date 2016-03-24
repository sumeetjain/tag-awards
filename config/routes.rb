Rails.application.routes.draw do 

  get "users/home" => 'users#home'

  namespace :admin do
    resources :users
    resources :awards
    resources :nominations
    resources :plays
    resources :theaters

  root to: "users#index"
  end


  devise_for :users
  "home#index"

  root to: 'static_pages#home'
end
