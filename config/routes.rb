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

  get "viewings/new" => 'viewings#new'

  post "viewings/create" => 'viewings#create'

  get "viewings/:id/edit" => 'viewings#edit'

  post "viewings/:id/update" =>'viewings#update'

  'users#index'

  root to: 'static_pages#home'

  get "nomination_ballot" => 'nominations#nomination_ballot'

end

