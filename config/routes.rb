Rails.application.routes.draw do
  root "pages#home"
  get "pages/home", to: 'pages#home'

  # get '/recipes', to: 'recipes#index'
  # get '/recipes/new', to: 'recipes#new', as:'new_recipe'
  # get 'recipes/:id', to: 'recipes#show', as:'recipe'
  # post '/recipes', to: 'recipes#create'

  resources :recipes do
    resources :comments, only: [:create]
  end

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout',to:'sessions#destroy'

  resources :ingredients, except: [:destroy]

  mount ActionCable.server => '/cable'

end
