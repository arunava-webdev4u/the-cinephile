Rails.application.routes.draw do
  root "home#index"
  get "movies/search", to: "movies#search_movies_by_name", defaults: { format: :json }
  get "movies/popular", to: "movies#popular", defaults: { format: :json }
  get "movies/top_rated", to: "movies#top_rated", defaults: { format: :json }
  get "movies/upcoming", to: "movies#upcoming", defaults: { format: :json }
  get "movies/now_playing", to: "movies#now_playing", defaults: { format: :json }

  get "tv/search", to: "movies#search_tv_shows_by_name", defaults: { format: :json }

  resources :users, only: [ :index, :create, :show ]
end
