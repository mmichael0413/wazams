Rails.application.routes.draw do

  root to: 'home#index'
  resources :messages, only: :create

end
