Rails.application.routes.draw do

  root to: 'home#index'
  resources :messages, only: :create do
    post :search, on: :collection
  end

end
