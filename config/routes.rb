Rails.application.routes.draw do
  resources :niches do
    collection do
      post :move
      get :highlight
    end
  end
  resources :items

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
  resources :free_item_requests do
    collection do
      get :new
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :users
  root to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
