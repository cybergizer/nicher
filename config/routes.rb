Rails.application.routes.draw do
  resources :items
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # devise_for :users, :controllers => { :confirmations => 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: %i[get patch], :as => :finish_signup
  match '/users/:id/settings' => 'users#settings', via: %i[get patch], :as => :settings
  root to: 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
