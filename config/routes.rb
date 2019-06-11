Rails.application.routes.draw do
  get 'sessions/new'
  root  'static_pages#home'
  get   '/about',   to: 'static_pages#about'
  get   '/tos',     to: 'static_pages#tos'
  get   '/signup',  to: 'users#new'
  post  '/signup',  to: 'users#create'
  resources :users
end
