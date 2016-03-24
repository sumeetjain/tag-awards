Rails.application.routes.draw do 

  namespace :admin do
    resources :users
    resources :awards
    resources :nominations
    resources :plays
    resources :theaters

  root to: "users#index"
  end

  get "users/dashboard" => 'users#dashboard'

  devise_for :users


  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  # "devise/passwords#edit"

# Got this in iTerm when I created custom controllers using the Devise 
# generator.

# Some setup you must do manually if you haven't yet:

#   Ensure you have overridden routes for generated controllers in your routes.rb.
#   For example:

#     Rails.application.routes.draw do
#       devise_for :users, controllers: {
#         sessions: 'users/sessions'
#       }
#     end

end
