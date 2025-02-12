class Api::V1::TvshowsController < Api::V1::ApplicationController
  def search
    query = params[:query]
    if query.present?
      tmdb_service = TmdbService.new
      @tv_shows = tmdb_service.search_tv_shows(query)
      render json: @tv_shows
    else
      render json: { error: "Query parameter is missing" }, status: :bad_request
    end
  end
end