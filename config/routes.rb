Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only: [:new, :create]
  delete '/logout' => 'sessions#destroy'
  resources :users
end
