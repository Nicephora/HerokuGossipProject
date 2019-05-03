Rails.application.routes.draw do

  root 'gossips#index'
  get '/welcome/:first_name', to: 'welcome#message'
  get '/contact', to: 'contact#contact'
  get '/team', to: 'team#team'

  resources :users, only: [:show, :new, :create]
  resources :gossips, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  resources :cities, only: [:show]
  resources :sessions, only: [:destroy, :new, :create]
  resources :gossips do
    resources :comments
  end
  resources :comments, only: [:new, :create, :show, :edit, :update, :destroy]

end
