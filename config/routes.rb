Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resources :users, except: [:delete, :destory, :index] do
    resources :reviews, only: :show
  end

  resources :businesses, except: [:delete, :destroy]

  root to: 'pages#front'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/log_out', to: 'sessions#destroy'
  get '/register', to: 'users#new'
end
