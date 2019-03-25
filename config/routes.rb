Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get 'app', to: 'static_pages#app'
end
