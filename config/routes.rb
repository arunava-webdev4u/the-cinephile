Rails.application.routes.draw do
  get 'movies/search', to: 'movies#search', defaults: { format: :json }
  # Other routes
end