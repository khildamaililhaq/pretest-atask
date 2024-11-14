Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  namespace :auths do
    post :login
    post :logout
    get :me
  end

  namespace :api do
    resource :users, only: :show do
      collection do
        post :deposit
        post :transfer
        post :withdraw
      end
    end
    resource :teams, only: :show do
      collection do
        post :deposit
        post :transfer
        post :withdraw
      end
    end
    resource :stocks, only: :show do
      collection do
        post :deposit
        post :transfer
        post :withdraw
      end
    end
  end

  resources :entities, only: :index

  # Defines the root path route ("/")
  # root "posts#index"
end
