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

  get "users/register"

  get "users/register/:voter_token" => 'users#register'

  put "users/set_password" => 'users#set_password'
  #devise_for :users

  #{}"home#index"

  devise_for :users, skip: [:registrations]                                          

  get "viewings/new" => 'viewings#new'

  post "viewings/create" => 'viewings#create'

  get "viewings/:id/edit" => 'viewings#edit'

  post "viewings/:id/update" => 'viewings#update'

  get "viewings/index" => 'viewings#index'

  delete "viewings/delete" => 'viewings#delete'
  

  'users#index'

  get "nominations" =>'static_pages#noms'

  root to: 'static_pages#home'

  get "nomination_ballot" => 'nominations#nomination_ballot'

  #Consolidated both theater creation form and play creation form onto one vie w page in plays, and put both in the plays controller.
  #get "theaters/new" => 'theaters#new'

  # Made the below route into a form that gets rendered on the new viewing page.
  #get "plays/new", to: 'plays#new', as: 'add_play'

  post "plays/create" => 'plays#create_play'

  post "viewings/create/multiple" => 'viewings#create_multiple'

end

