Rails.application.routes.draw do
  namespace :auth do
    root to: "logins#new"

    get 'login', to: 'logins#new'
    post 'login', to: 'logins#create'

    get 'googlelogin/create', to: 'googlelogins#create', as: :create_google_login
  end

  resources :users
end
