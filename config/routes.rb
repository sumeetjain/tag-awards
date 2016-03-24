Rails.application.routes.draw do 

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
end

