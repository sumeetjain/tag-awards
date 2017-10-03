Rails.application.routes.draw do
  get '/login',          to: 'sessions#new'
  post '/login',         to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'

  get '/users/:id/plays', to: 'users#plays', as: 'user_plays'
  resources :users, only: [:edit]
  patch '/users/:id/email', to: 'users#update_email', as: 'update_user_email'
  patch '/users/:id/password', to: 'users#update_password', as: 'update_user_password'

  resources :username_recovery, only: [:new, :create]
  resources :password_resets,   only: [:new, :create, :edit, :update]

  root 'sessions#new'
end
