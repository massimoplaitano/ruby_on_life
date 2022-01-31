Rails.application.routes.draw do
  resources :games, param: :code do
    patch 'publish/:public', action: :publish, on: :member, as: :publish
  end
  get '/games/:code/:generation', to: 'games#show', constraints: { generation: /\d+/ }, as: :game_generation
  get '/games/:code/:generation/download', to: 'games#download', constraints: { generation: /\d+/ }, as: :download_game

  devise_for :users

  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'
end
