WpcampApi::Application.routes.draw do

  root to: 'pages#index'

  resources :wordcamps, only: [ :show, :index ]

end
