Rails.application.routes.draw do
  resources :books do
    member do
      patch :publish
      patch :unpublish
    end
    collection do
      get :unpublished
    end
  end

  resources :authors
end
