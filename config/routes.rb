Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resources :users, except: [:index, :delete] do
    resources :reviews, only: :show

    member do
      get 'settings', to: 'users#edit_settings'
      patch 'settings', to: 'users#update_settings'
    end
  end

  resources :reviews, only: :index

  resources :businesses do
    resources :reviews, except: :index

    collection do
      get '/search', to: 'businesses#query'
    end
  end

  root to: 'pages#front'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/log_out', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/search', to: 'businesses#query'
end
