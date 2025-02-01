Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root "roulettes#active"

  resources :users, only: [ :show, :index ]

  resources :charges, only: [ :new, :create ]

  resources :roulettes, only: [ :show ] do
    get :active, :finished, on: :collection
    member do
      patch :gamble
    end
  end
end
