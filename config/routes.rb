Rails.application.routes.draw do
  devise_for :users
  root "users#index"
    
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do 
      resources :likes, only: [:create]
      resources :comments, only: [:create]
    end
  end
end
