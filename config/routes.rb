Rails.application.routes.draw do
  resources :servers
  devise_for :users
  root 'static_pages#home'
  get 'app', to: 'static_pages#app'

  namespace :api do
    get :login
    get :logout
    get :ram
    get :disk
    get :tasks
    get :servers
    get :reboot
  end
end
