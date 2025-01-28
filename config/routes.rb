Rails.application.routes.draw do
  root "home#index"
  get 'movies/search', to: 'movies#search', defaults: { format: :json }
  resources :users, only: [:index, :create, :show]
  # Other routes
end