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
  get '/albums/show_albums/artist/:artist/user/:user_id', to: 'albums#show_albums', as: 'show_albums'
  get '/albums/new/artist/:artist', to: 'albums#new', as: 'new_album'
  get '/albums/confirm_delete/artist/:artist_id/album/:album_id/user/:id', to: 'albums#confirm_delete', as: 'confirm_delete'
  post '/albums/delete_album/:id', to: 'albums#destroy', as: 'delete_album'
  get '/albums/edit_album/album/:id/user/:user_id', to: 'albums#edit', as: 'edit_album'
  get '/artist/user/:id', to: 'artists#index', as: 'artists'

  resources :albums
  resources :artists
  resources :users, only: [:new, :create, :edit, :update]
end
