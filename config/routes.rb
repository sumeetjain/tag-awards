Rails.application.routes.draw do
  root 'sessions#new'
  get '/login',       to: 'sessions#new'
  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  get '/plays',       to: 'users#plays'
end
