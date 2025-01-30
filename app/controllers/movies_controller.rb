class MoviesController < ApplicationController
  def search_movies_by_name
    query = params[:query]
    if query.present?
      tmdb_service = TmdbService.new
      @movies = tmdb_service.search_movies(query)
      render json: @movies
    else
      render json: { error: "Query parameter is missing" }, status: :bad_request
    end
  end

  def search_tv_shows_by_name
    query = params[:query]
    if query.present?
      tmdb_service = TmdbService.new
      @tv_shows = tmdb_service.search_tv_shows(query)
      render json: @tv_shows
    else
      render json: { error: "Query parameter is missing" }, status: :bad_request
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

  def upcoming
    tmdb_service = TmdbService.new
    @upcoming = tmdb_service.upcoming

    if @upcoming.present?
      render json: @upcoming
    else
      render json: { error: "No upcoming movies found" }, status: :not_found
    end
  end

  def now_playing
    tmdb_service = TmdbService.new
    @now_playing = tmdb_service.now_playing

    if @now_playing.present?
      render json: @now_playing
    else
      render json: { error: "No now_playing movies found" }, status: :not_found
    end
  end
end
