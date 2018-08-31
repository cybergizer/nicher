Rails.application.routes.draw do
  resources :niches do
    collection do
      post :move
      get :highlight
    end
  end
  resources :items

  post 'free_item', action: :show_free_item, controller: 'welcome'

  post 'new_request', action: :new, controller: 'free_item_requests'
  post 'give_away', action: :give_away, controller: 'free_item_requests'
  get 'filter_notifications', action: :filter_notifications, controller: 'free_item_requests'

  get 'generate_link', action: :generate_link, controller: 'shared_items'
  get 'share', action: :share, controller: 'shared_items'
  resources :rent_items, only: %i[show edit update] do
    collection do
      get 'rent_form'
      post 'rent'
      delete 'repay'
    end
  end
  resources :categories do
    collection do
      post :move
    end
  end
  match "/404", to: 'errors#not_found', via: :all
  match "/500", to: 'errors#internal_server_error', via: :all
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations' }
  resources :users
  match '/users/:id/finish_signup' => 'users#finish_signup', via: %i[get patch], :as => :finish_signup
  match '/users/:id/settings' => 'users#settings', via: %i[get patch], :as => :settings
  root to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
