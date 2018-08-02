Rails.application.routes.draw do
  resources :items
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
