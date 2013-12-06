WpcampApi::Application.routes.draw do

  get '/page/:page' => 'pages#index'
  root to: 'pages#index'

  resources :wordcamps, only: [ :show, :index ] do
    collection do
      get 'search'
    end
  end

end
