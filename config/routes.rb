Rails.application.routes.draw do
  root to: 'books#index'
  devise_for :admins
  devise_for :users

  namespace :users do
    root to: 'books#index'
  end

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
    get 'sign_in', to: 'devise/sessions#new'
  end

  resources :customers, only: [:index, :show, :destroy] do
    collection do
      patch :block
      patch :unblock
    end
  end

  resources :books do
    member do
      get :new_author
      post :author
      patch :publish
      patch :unpublish
    end
    collection do
      get :unpublished
    end
  end

  resources :authors do
    member do
      get :new_book
      post :book
    end
  end

  namespace :users do
    resources :books, only: [:index, :show]
    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        post :add_book
        post :remove_book
        get :cart
      end
    end
  end
end
