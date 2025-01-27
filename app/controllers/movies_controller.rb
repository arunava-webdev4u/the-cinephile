class MoviesController < ApplicationController
    def search
      query = params[:query]
      if query.present?
        tmdb_service = TmdbService.new
        @movies = tmdb_service.search_movies(query)
        render json: @movies
      else
        render json: { error: 'Query parameter is missing' }, status: :bad_request
      end
    end
end