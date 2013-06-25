Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'static_pages#front'

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:show, :create]
  end
  get 'home', to: 'videos#index'

  resources :categories, only: [:show]

  resources :users, only: [:create]
  get 'register', to: 'users#new'
  
  resources :sessions, only: [:create]
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  get 'my_queue', to: 'queue_items#index'

end
