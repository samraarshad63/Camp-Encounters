Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { registrations: "users/registrations" }
  get "/pages/:page" => "pages#show"
end
