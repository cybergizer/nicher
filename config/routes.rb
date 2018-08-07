Rails.application.routes.draw do
  get 'home/index'
  get 'welcome/home'
  resources :items

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
