Rails.application.routes.draw do
  get "orders/show"
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
   root to: "products#index"

   resources :products, only: [:index, :show]
   resources :categories, only: [:show]

   resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: :add_item
    delete 'remove_item/:product_id', to: 'carts#remove_item', as: :remove_item
    patch 'update_item/:product_id', to: 'carts#update_item', as: :update_item
    post 'checkout', to: 'carts#checkout', as: :checkout
   end

   resources :orders, only: [:show]

   get 'profile', to: 'users#show', as: :profile
end
