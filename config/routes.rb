Rails.application.routes.draw do
  root 'messages#index'
  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy', as: :logout
  resources :users
  resources :messages
  resources :friendships do
    collection do
      get 'accept/:user_request_id' => 'friendships#accept', as: :accept
    end
  end
end
