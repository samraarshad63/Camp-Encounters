Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  devise_for :admin, controllers: { sessions: "admin/sessions" }

  root 'home#index', as: :home
  get "/pages/:page", to: "pages#show", as: :pages

  namespace :admin do
    resources :users
    resources :camps do
      member do
        patch :change_camp_status
      end
    end
  end

  resources :admin, only: [:index, :show] 
  resources :users do
    member do
      get :show_camps
      post :select_camp
      get :camp_intro
      get :check_camp_date
      get :dashboard
    end
  end
  resources :camp_applications
end
