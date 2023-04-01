Rails.application.routes.draw do
  get 'splash_screen/home'
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'groups#index'
    end

    unauthenticated do
      root 'splash_screen#unauth_home', as: :unauthenticated_root
    end
  end

  resources :groups do
    resources :entries
  end
end
