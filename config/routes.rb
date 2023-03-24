Rails.application.routes.draw do
  root "pages#home"

  resources :articles#, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  get 'signup' => 'users#new'
  # post 'users' => 'users#create'
  resources :users, except: [:new]
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Defines the root path route ("/")
end
