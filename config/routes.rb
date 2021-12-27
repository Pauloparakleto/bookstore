Rails.application.routes.draw do
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
    resources :cart, only: [:index, :create] do
      collection do
        post :add_book
        post :remove_book
      end
    end

    resources :orders, only: [:index, :show, :new, :create] do
      collection do
        post :add_book
        post :remove_book
        get :cart
      end
    end
  end
end
