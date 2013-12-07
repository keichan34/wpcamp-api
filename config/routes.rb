WpcampApi::Application.routes.draw do

  devise_for :users, path: 'admin', path_names: {
    sign_in: :login,
    sign_out: :logout
  }

  get '/admin' => 'admin_pages#index'

  get '/page/:page' => 'pages#index'
  root to: 'pages#index'

  resources :wordcamps, only: [ :show, :index ] do
    collection do
      get 'search'
    end
  end

end
