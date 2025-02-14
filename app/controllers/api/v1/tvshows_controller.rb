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

  def airing_today
    tmdb_service = TmdbService.new
    @airing_today = tmdb_service.airing_today

    if @airing_today.present?
      render json: @airing_today
    else
      render json: { error: "No airing_today movies found" }, status: :not_found
    end
  end

  def on_the_air
    tmdb_service = TmdbService.new
    @on_the_air = tmdb_service.on_the_air

    if @on_the_air.present?
      render json: @on_the_air
    else
      render json: { error: "No on_the_air movies found" }, status: :not_found
    end
  end

  def popular
    tmdb_service = TmdbService.new
    @popular = tmdb_service.popular

    if @popular.present?
      render json: @popular
    else
      render json: { error: "No popular movies found" }, status: :not_found
    end
  end

  def top_rated
    tmdb_service = TmdbService.new
    @top_rated = tmdb_service.top_rated

    if @top_rated.present?
      render json: @top_rated
    else
      render json: { error: "No top_rated movies found" }, status: :not_found
    end
  end
end
