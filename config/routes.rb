Rails.application.routes.draw do
  resources :messages
  resources :chats
  resources :servers
  devise_for :users
  root 'static_pages#home'
  get 'app', to: 'static_pages#app'

  namespace :api_chat do
    get :new_chat
    get :chats
    get :messages
    get :send_message
  end

  namespace :api do
    get :login
    get :logout
    get :ram
    get :disk
    get :tasks
    get :servers
    get :reboot
    get :databases_index
    get :db_stats
    get :db_remove_user
    get :start_task
    get :stop_task
    get :create_account
    get :create_server
  end
end
