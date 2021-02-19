Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  basic_actions = [:create, :index, :show, :destroy]

  root to: 'home#home'

  namespace :api do
    get 'user/:id_1/messages-from-sender/:id_2', to: 'messages#receivedMessagesFromSender'
    get 'user/:id/messages-to-user', to: 'messages#receivedMessagesToUser'
    get 'recent-messages', to: 'messages#recentMessages'

    resources :messages, only: basic_actions
    resources :users, only: basic_actions
  end
end
