Rails.application.routes.draw do
  resources :books do
    member do
      patch :publish
      patch :unpublish
    end
  end
end
