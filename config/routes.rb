Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :blogs

  root to: 'tips#index'
  resources :users, only: :show
  resources :tips do
    collection do
      get 'search'
      get 'tagsearch'
      get 'detail_search'
      get 'trend'
    end
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
end
