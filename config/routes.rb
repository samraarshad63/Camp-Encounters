Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  devise_for :admin, controllers: { sessions: "admin/sessions" }

  root 'home#index', as: :home
  get "/pages/:page" => "pages#show", as: :pages

  namespace :admin do
    resources :users
    resources :camps
  end

  resources :users do
    member do
      get :show_camps
      post :select_camp
      get :personal_info
    end
  end
  resources :admin, only: [:index, :show] 
end
