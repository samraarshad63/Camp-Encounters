Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  devise_for :admins, controllers: { sessions: "admin/sessions" }

  root 'home#index', as: :home
  get "/pages/:page" => "pages#show", as: :pages

  resources :users
  resources :admin, only: [:index, :show] do
    member do 
      get "view_user"
      get "edit_user"
    end
  end
end
