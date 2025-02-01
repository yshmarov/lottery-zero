Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root "roulettes#index"

  resources :users, only: [ :show, :index ]

  resources :charges, only: [ :new, :create ]

  resources :roulettes, only: [ :index, :show ] do
    get :finished, on: :collection
    member do
      patch :gamble
    end
  end
end
