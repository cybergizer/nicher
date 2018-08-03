Rails.application.routes.draw do
  get 'home/index'
  mount RailsAdmin::Engine => '/dbadmin', as: 'rails_admin'
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
