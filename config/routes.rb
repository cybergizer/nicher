Rails.application.routes.draw do
  get 'home/index'
  get 'welcome/home'
  resources :items
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # root to: 'items#index'
  get 'home', to: 'home#index', as: 'user_root'
  root 'home#index'
end
