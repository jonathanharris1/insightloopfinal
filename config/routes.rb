Rails.application.routes.draw do

  get 'improvements/index'
  get 'improvements/show'
  get 'analyses/index'
  get 'analyses/show'


  get 'classifications/index'
  get 'classifications/show'
  devise_for :users
  root to: "conversations#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :conversations, only: [:index, :show, :edit, :update] do
    resources :classifactions, only: [:index, :show]
    resources :analyses, only: [:index, :show]
    resources :improvements, only: [:index, :show]
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
