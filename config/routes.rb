Rails.application.routes.draw do

  devise_for  :users,
  :controllers => {:registrations => "users/registrations"},
  :path => '',
  :path_names  => {
    :sign_in   => 'login',
    :sign_up   => 'register',
    :sign_out  => 'logout',
    :edit      => 'settings/account'
  }

  resource :instagram do
    get :connect
    get :callback
  end

  authenticated do
    root "dashboard#index", :as => :authenticated_root

    resources :dashboard, only: [:index]

    resources :settings do
      collection do
        resources :payment, only: [:index, :new, :create]
        resources :socialconnections, path: :connections do
          collection do
            get :connect, as: :connect
            get :callback
            get :clear_connection, as: :clear
          end
        end
      end
    end
  end

  resources :offers

  get '/:id' => 'profiles#show', as: :user_profile

  root "landing#index"
end
