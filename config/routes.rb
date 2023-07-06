require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :auth do
    root to: "logins#new"

    get 'login', to: 'logins#new'
    post 'login', to: 'logins#create'
    post 'login', to: 'logins#destroy'

    get 'googlelogin/create', to: 'googlelogins#create', as: :create_google_login

    get "sign_up", to: "registrations#create"
    post "sign_up", to: "registrations#create"
  end

  resources :reset_passwords, only: %i[edit update]
  resources :users

  resources :compensation_requests
  patch 'approve', to: 'compensation_requests#approve'
end
