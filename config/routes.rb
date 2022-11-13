Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'teams#index'
  resources :teams, only: %i[new create index] do
    resources :invitations, only: %i[new create]
  end

  resources :pings, only: %i[create]
  resources :pongs, only: %i[create update]
  resources :invitations, only: %i[index update]
end
