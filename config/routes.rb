Rails.application.routes.draw do
  devise_for :users
  root to: 'tips#index'
  resources :users, only: :show
  resources :tips do
    collection do
      get 'search'
    end
  end
end
