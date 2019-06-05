Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/tos',     to: 'static_pages#tos'
  get '/signup',  to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
