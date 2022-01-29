Rails.application.routes.draw do
  resources :games, param: :code
  get '/games/:code/:generation', to: 'games#show', constraints: { generation: /\d+/ }, as: :game_generation

  devise_for :users

  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'
end
