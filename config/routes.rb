Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'videos#index'

  resources :videos, only: [:index, :show]

  resources :categories, only: [:show]

end
