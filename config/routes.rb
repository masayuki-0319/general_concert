Rails.application.routes.draw do
  root    'static_pages#home'
  get     '/about',   to: 'static_pages#about'
  get     '/tos',     to: 'static_pages#tos'
  get     '/signup',  to: 'users#new'
  post    '/signup',  to: 'users#create'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
  resources :users
  resources :music_posts, only: [:create, :destroy]
end
