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

  get "" => redirect("/users/home")
  get "users/home" => 'users#home'
  get "users/register"


  get "users/settings_page" => 'users#settings_page'
  post "users/change_settings" => 'users#settings_changed'
  get "users/register/:voter_token" => 'users#set_password'
  post "users/set_password" => 'users#set_password'
  put "users/set_password_via_token" => 'users#update'

  devise_for :users, skip: [:registrations]

  resources :passwords

  get "viewings/new" => 'viewings#new'
  post "viewings/create" => 'viewings#create'
  get "viewings/:id/edit" => 'viewings#edit'
  post "viewings/:id/update" => 'viewings#update'
  get "viewings/index" => 'viewings#index'
  delete "viewings/delete" => 'viewings#delete'
  post "viewings/create/multiple" => 'viewings#create_multiple'
  
  'users#index'

  root to: 'static_pages#home'

  get "nominations" =>'static_pages#noms'
  get "nomination_ballot" => 'nominations#nomination_ballot'
  post "save_nominee" => 'nominations#save_nominee'

  get "nominations/index"


  post "plays/create" => 'plays#create_play'

  get "votes/ballots_page" => 'votes#ballots_page'
end

