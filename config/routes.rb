PhotoTagging::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show] do
    resources :images, only: [:index, :new]
  end

  resources :images, only: [:show, :create]

  root to: 'sessions#new'

  match 'signup' => 'users#new'
  match 'login'  => 'sessions#new'
  match 'logout' => 'sessions#destroy'
end
