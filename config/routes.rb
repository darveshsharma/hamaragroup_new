Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :profile, only: %i[edit update]

  resources :membership_payments, only: %i[new create] do
    collection do
      post :verify
    end
  end

  resources :properties do
    member do
      get :download_documents
    end

    resources :documents, only: %i[create destroy]
    resources :consultation_requests, only: %i[new create]
    resources :payments, only: :new do
      member do
        post :verify
      end
    end
  end

  resources :consultation_requests, only: %i[new create]

  get "home/index"
end
