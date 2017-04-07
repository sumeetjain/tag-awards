Rails.application.routes.draw do 

  patch "user/viewings" => 'viewings#update', as: :user_viewings

  namespace :admin do
    resources :plays
    resources :artists
    resources :roles
    resources :potential_nominations

    resources :awards
    resources :theaters
    resources :viewings

    resources :nominations do
      collection do
        get "top_ten" => 'nominations#top_ten'
        post "reset" => 'nominations#reset_ballot'
      end

      member do
        patch "toggle_approval" => 'nominations#toggle_approval'
        post "build_ballot" => 'nominations#build_ballot'
      end
    end

    resources :ballot_items
    
    resources :votes do
      collection do
        get "export"
        get "export_viewings"
        post "close"
      end
    end

    resources :voting_periods

    resources :winners do
      collection do
        get "calculate_winners" => 'winners#show_calculate_winners'
        post "calculate" => 'winners#calculate_winners'
        get "scores" => 'winners#scores'
      end
    end

    resources :users do
      collection do
        post "export/usernames_and_passwords" => 'users#export'
      end
    end

    root to: "users#index"
    post 'set_period' => 'voting_periods#set_period'
  end

  root to: "users#home"
  get "users/home" => 'users#home'
  get "users/settings_page" => 'users#settings_page'
  post "users/change_settings" => 'users#settings_changed'
  post "send/email/nominations" => 'users#nomination_email'
  post "send/email/ballots" => 'users#ballot_email'
  get "users/register/:secret_number" => 'users#set_password', as: "secret_register"
  post "users/set_password" => 'users#set_password'
  put "users/set_password_via_token" => 'users#update'
  devise_for :users
  get "viewings/new" => 'viewings#new'
  post "viewings/create" => 'viewings#create'
  get "viewings/:id/edit" => 'viewings#edit'
  post "viewings/:id/update" => 'viewings#update'
  get "viewings/index" => 'viewings#index'
  delete "viewings/delete" => 'viewings#delete'
  post "viewings/create/multiple" => 'viewings#create_multiple'
  get "nomination_ballot" => 'nominations#nomination_ballot'
  get "ballot_helper" => 'nominations#index'
  post "save_nominee" => 'nominations#save_nominees'
  post "plays/create" => 'plays#create_play'

  # Final Ballot Routes
  resources :ballots, only: [:new, :create]
end

