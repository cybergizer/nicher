Rails.application.routes.draw do
  resources :niches
  resources :items do
    collection do
      get 'rent_form'
    end
    member do
      post 'rent'
      delete 'repay'
    end
  end
  resources :categories
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :users
  root to: 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
