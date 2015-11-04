Rails.application.routes.draw do
  devise_for :users

  root to: 'visitors#index'

  get '/auth/:provider/callback' => 'sessions#create'

  as :user do
    get  '/register' => 'users/registrations#new', :as => :registration_new
    post '/register' => 'users/registrations#create', :as => :registration
    get  '/login' => 'devise/sessions#new', :as => :signin
    post '/login' => 'devise/sessions#create', :as => :session
    get  '/logout' => 'devise/sessions#destroy', :as => :signout
  end

  get '/auth/failure' => 'sessions#failure'

  localized do
    get  '/tos' => 'visitors#tos'
    get '/privacy' => 'visitors#privacy'
    get '/about' => 'visitors#about'

    as :user do
      get  '/register' => 'users/registrations#new', :as => :registration_new
      get  '/login' => 'devise/sessions#new', :as => :signin
      get  '/logout' => 'devise/sessions#destroy', :as => :signout
    end

    resources :visitors do
      collection do
        get 'download_csv_project', :path => "descargar_csv_proyectos"
      end
    end
    resources :users, except: :destroy

    namespace :search do
      resources :projects
    end

    get '/projects' => 'projects#list', :as => :projects_list

    resources :organizations, except: [:new, :create, :destroy] do
      collection do
        get 'download_csv_project', :path => "descargar_csv_proyectos"
      end
      resources :projects, except: :destroy
    end
    resources :collaborators, except: [:new, :create, :destroy]
    resources :investors, except: [:new, :create, :destroy]
  end
end
