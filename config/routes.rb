Rails.application.routes.draw do
  root "home#index"
  get 'movies/search', to: 'movies#search', defaults: { format: :json }
  # Other routes
end