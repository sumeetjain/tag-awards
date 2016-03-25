Rails.application.routes.draw do 

  namespace :admin do
    resources :users
    resources :awards
    resources :nominations
    resources :plays
    resources :theaters
    resources :viewings

    root to: "users#index"
  end

  get "users/home" => 'users#home'


  devise_for :users

  "home#index"

  get "viewings/new" => 'viewings#new'

  post "viewings/create" => 'viewings#create'

  'users#index'

  root to: 'static_pages#home'

  get "nomination_ballot" => 'nominations#nomination_ballot'

  get "theaters/new" => 'theaters#new'

  post "theaters/create" => 'theaters#create'

end

