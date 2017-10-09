Rails.application.routes.draw do
  get '/login',          to: 'sessions#new'
  post '/login',         to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'


  scope :users do
    get '/:id/plays', to: 'users#plays', as: 'user_plays'
    patch '/:id/email', to: 'users#update_email', as: 'update_user_email'
    patch '/:id/password', to: 'users#update_password', as: 'update_user_password'
  end

  resources :users, only: [:edit]
  resources :username_recovery, only: [:new, :create]
  resources :password_resets,   only: [:new, :create, :edit, :update]

  post '/viewings/:id', to: 'viewings#update_user', as: 'update_user_viewings'

  root 'sessions#new'
end
