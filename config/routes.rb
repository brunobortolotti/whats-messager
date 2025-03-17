Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  resources :users, only: [:index]
  resources :chats, only: [:index]
  resources :messages, only: [:index, :create] do
    get :tracks, on: :member, action: :message_tracks
  end
end
