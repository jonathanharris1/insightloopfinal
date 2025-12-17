Rails.application.routes.draw do
  get "home", to: "pages#home", as: :home
  get "dashboard", to: "pages#dashboard"
  devise_for :users
  root to: "pages#dashboard"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :conversations, only: [:index, :show, :edit, :update] do
    get "insight_list", on: :collection
    get "insight", on: :member
  end
  resources :classifications, only: [:index, :show]
  resources :chats, only: [:create, :show] do
    resources :messages, only: [:create]
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
