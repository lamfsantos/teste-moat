Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "static_pages#index"

  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to:'sessions#destroy'

  resources :albums
  resources :users, only: [:new, :create, :show, :edit, :update]
end
