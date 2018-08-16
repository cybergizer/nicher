Rails.application.routes.draw do
  resources :niches
  resources :items
  get 'rent_form', controller: 'rent_items'
  post 'rent', action: :rent, controller: 'rent_items'
  delete 'repay', controller: 'rent_items'
  resources :categories
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :users
  root to: 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
