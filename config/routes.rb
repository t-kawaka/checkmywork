Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :tasks
  root to: 'tasks#index'

  resources :users
end
