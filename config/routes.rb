Rails.application.routes.draw do
  resources :items
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'items#index'
end
