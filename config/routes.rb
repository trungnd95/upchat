Rails.application.routes.draw do
  root 'users#new'
  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy', as: :logout
  resources :users
  resources :messages do
    collection do
      get :sent
      get :received
    end
  end
end
