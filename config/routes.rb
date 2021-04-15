Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_for :admins

  get 'home/index'
  get "/pages/:page" => "pages#show", as: :pages

  resources :users, only: [:index, :show]
end
