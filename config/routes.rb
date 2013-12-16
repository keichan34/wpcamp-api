WpcampApi::Application.routes.draw do

  devise_for :users, path: 'admin', path_names: {
    sign_in: :login,
    sign_out: :logout
  }

  get '/admin' => 'admin_pages#index'
  namespace :admin do
    resources :wordcamps, only: [ :show, :index ], as: :word_camps do
      collection do
        get 'page/:page' => 'wordcamps#index'
        get 'location/:location', action: :location
      end

      resources :banners
    end
  end


  scope ":locale", locale: /en|ja/ do
    root to: 'pages#index', as: :root_with_locale
    get 'page/:page' => 'pages#index_page'
  end

  root to: 'pages#redirect_to_current_locale'


  # API routes

  namespace :v1 do

    resources :wordcamps, only: [ :show, :index ] do
      collection do
        get 'list'

        get 'search'

        get 'location/:location', action: :location
      end
    end

  end

end
