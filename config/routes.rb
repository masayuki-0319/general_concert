Rails.application.routes.draw do
  root    'static_pages#home'
  get     '/about',                   to: 'static_pages#about'
  get     '/tos',                     to: 'static_pages#tos'
  get     '/signup',                  to: 'users#new'
  post    '/signup',                  to: 'users#create'
  get     '/login',                   to: 'sessions#new'
  post    '/login',                   to: 'sessions#create'
  get     '/auth/:provider/callback', to: 'sessions#create'
  get     '/auth/failure',            to: 'sessions#failure'
  delete  '/logout',                  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :music_posts,        only: [:index, :show, :create, :destroy]
  resources :music_likes,        only: [:create, :destroy]
  resources :user_relationships, only: [:create, :destroy]
  resources :music_comments,     only: [:create, :destroy]
end
