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

  authenticated do
    root "offers#index", :as => :authenticated_root

    resources :settings do
      collection do
        resources :payment, only: [:index, :new, :create]
      end
    end

    resources :offers
  end

  root "landing#index"
end
