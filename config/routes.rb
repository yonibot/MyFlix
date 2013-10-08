Myflix::Application.routes.draw do
  
# Controllers:
#
# videos
# reviews
# categories
# queue_items
# users
# sessions
# friends


  get 'ui(/:action)', controller: 'ui'

  root to: 'static_pages#front'

  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :payments, only: [:index]
  end

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:show, :create]
  end
  get 'home', to: 'videos#index'

  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]

  resources :users, only: [:create, :show]
  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'

  resources :sessions, only: [:create]
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'

  get 'people', to: 'relationships#index'
  resources :relationships, only: [:destroy, :create]

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'static_pages#expired_token'

  resources :invitations, only: [:new, :create]

  resources :payments, only: [:create]

  mount StripeEvent::Engine => '/stripe_webhooks'


end




