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
end
