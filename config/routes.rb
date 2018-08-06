Rails.application.routes.draw do
  resources :items
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'items#index'
end
