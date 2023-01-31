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
  #get 'show_albums', to: 'albums#show_albums'
  get '/show_albums/:artist', to: 'albums#show_albums', as: 'show_albums'
  get '/new/:artist', to: 'albums#new', as: 'new_album'
  get '/confirm_delete/:artist_id/:album_id/:id', to: 'albums#confirm_delete', as: 'confirm_delete'
  post 'delete_album/album_id/:id', to: 'albums#destroy', as: 'delete_album'

  resources :albums
  resources :artists
  resources :users, only: [:new, :create, :show, :edit, :update]
end
