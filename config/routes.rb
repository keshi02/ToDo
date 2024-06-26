Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "static_pages#top"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users
  resources :todos, only:[:create, :new, :destroy, :index, :show] do
    collection do
      get 'edit_multiple'
      patch 'update_multiple'
    end
  end
  resources :password_resets, only:[:new, :create, :edit, :update]
end
