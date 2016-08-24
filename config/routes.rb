Rails.application.routes.draw do 

  patch "user/viewings" => 'viewings#update', as: :user_viewings
  
  namespace :admin do

    get "/application/add_multiple", :controller => 'add_multiples',  
      :action => 'add_multiple'

    post "/application/add_multiple", :controller => 'add_multiples',  
      :action => 'create'

    resources :users do
      collection do
        post "export/usernames_and_passwords" => 'users#export'
      end
    end
    resources :awards do
      member do
        post "build_ballot" => 'awards#build_ballot'
      end
    end
    resources :ballot_items
    resources :nominations do
      collection do
        get "top_ten" => 'nominations#top_ten'
      end

      member do
        patch "toggle_approval" => 'nominations#toggle_approval'
      end
    end
    resources :plays
    resources :theaters
    resources :viewings
    resources :votes do
      collection do
        get "export"
        get "export_viewings"
        post "close"
      end
    end
    
    root to: "users#index"
  end

  root to: "users#home"
  get "users/home" => 'users#home'
  get "users/register"
  get "users/settings_page" => 'users#settings_page'
  post "users/change_settings" => 'users#settings_changed'
  post "send/email/nominations" => 'users#nomination_email'
  post "send/email/ballots" => 'users#ballot_email'
  get "users/register/:secret_number" => 'users#set_password', as: "secret_register"
  post "users/set_password" => 'users#set_password'
  put "users/set_password_via_token" => 'users#update'
  devise_for :users, skip: [:registrations]
  #resources :passwords
  get "viewings/new" => 'viewings#new'
  post "viewings/create" => 'viewings#create'
  get "viewings/:id/edit" => 'viewings#edit'
  post "viewings/:id/update" => 'viewings#update'
  get "viewings/index" => 'viewings#index'
  delete "viewings/delete" => 'viewings#delete'
  post "viewings/create/multiple" => 'viewings#create_multiple'
  get "nomination_ballot" => 'nominations#nomination_ballot'
  get "ballot_helper" => 'nominations#index'
  post "save_nominee" => 'nominations#save_nominee'
  post "close_nominations" => 'nominations#close_nominations'
  get "nominations/index"
  post "plays/create" => 'plays#create_play'

  # Final Ballot Routes
  resources :ballots, only: [:new, :create]
end

