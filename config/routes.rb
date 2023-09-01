Rails.application.routes.draw do
  devise_for :users
  root "users#index"
    
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do 
      resources :likes, only: [:create]
      resources :comments, only: [:create, :destroy]
    end
  end

  #API routes
  post '/auth/login', to: 'api/authentication#login'

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

  # namespace :api do
  #   namespace :v1 do
  #     get '/users/:user_id/posts', to: 'posts#index'
  #     get '/users/:user_id/posts/:post_id/comments', to: 'comments#index'
  #     post '/users/:user_id/posts/:post_id/comments', to: 'comments#create'
  #   end
  # end

end
