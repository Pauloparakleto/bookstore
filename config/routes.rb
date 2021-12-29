Rails.application.routes.draw do

  devise_for :users

  scope :user do
    root to: 'users/books#index'
  end

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy'
    get 'sign_in', to: 'devise/sessions#new'
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

  resources :orders, only: [:index, :show, :new, :create]

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
