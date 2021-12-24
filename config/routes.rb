Rails.application.routes.draw do
  resources :books do
    member do
      patch :publish
    end
  end
end
