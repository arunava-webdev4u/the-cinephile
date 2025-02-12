Rails.application.routes.draw do
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :movies, only: [] do
        collection do
          get :search, defaults: { format: :json }
          get :popular, defaults: { format: :json }
          get :top_rated, defaults: { format: :json }
          get :upcoming, defaults: { format: :json }
          get :now_playing, defaults: { format: :json }
        end
      end

      resources :tvshows, only: [] do
        collection do
          get :search, defaults: { format: :json }
          get :popular, defaults: { format: :json }
          get :top_rated, defaults: { format: :json }
          get :upcoming, defaults: { format: :json }
          get :now_playing, defaults: { format: :json }
        end
      end

      resource :users, only: [ :create, :show ]
    end
  end
end
