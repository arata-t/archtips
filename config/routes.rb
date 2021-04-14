Rails.application.routes.draw do
  devise_for :users
  root to: 'tips#index'
  resources :tips
end
