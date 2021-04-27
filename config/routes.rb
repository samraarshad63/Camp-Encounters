Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }
  devise_for :admin, controllers: { sessions: "admin/sessions" }

  root 'home#index', as: :home
  get "/pages/:page" => "pages#show", as: :pages
  get "/users/:id/camps" => "users#show_camps", as: :user_show_camps
  post "/users/:id/camp" => "users#select_camp", as: :user_select_camp
  get "/users/:id/camp/step-1" => "users#personal_info", as: :user_personal_info

  namespace :admin do
    resources :users
    resources :camps
  end

  resources :users
  resources :admin, only: [:index, :show] 
end
