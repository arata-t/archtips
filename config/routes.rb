Rails.application.routes.draw do
  devise_for :users
  root to: 'archtips#index'
  resources :archtips
end
