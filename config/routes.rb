Rails.application.routes.draw do
  devise_for :admins
  get 'home/index'
  devise_for :users, controllers: { registrations: "users/registrations" }
  get "/pages/:page" => "pages#show", as: :pages
end
