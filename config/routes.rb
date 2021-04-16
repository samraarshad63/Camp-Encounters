Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  devise_for :admin, controllers: { sessions: "admin/sessions" }

  root 'home#index', as: :home
  get "/pages/:page" => "pages#show", as: :pages

  namespace :admin do
    resources :users
  end

  resources :users
  resources :admin, only: [:index, :show] 
end
