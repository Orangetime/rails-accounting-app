Rails.application.routes.draw do
  namespace :auth do
    root to: "logins#new"

    get 'login', to: 'logins#new'
    post 'login', to: 'logins#create'
    post 'login', to: 'logins#destroy'

    get 'googlelogin/create', to: 'googlelogins#create', as: :create_google_login

    get "sign_up", to: "registrations#create"
    post "sign_up", to: "registrations#create"
  end

  resources :users
end
