Rails.application.routes.draw do
  devise_for :users
  root to: "movies#index"

  resources :movies do
    resources :comments, only: [:edit, :update, :new, :create]
  end

  resources :users, only: [:edit, :update]
end
