class Api::V1::PersonsController < Api::V1::BaseController
  def search
    query = params[:query]
    if query.present?
      @persons = tmdb_service.search_persons(query)
      render json: @persons
    else
      render json: { error: "Query parameter is missing" }, status: :bad_request
    end
  end

  def trending
    @trending_persons = tmdb_service.trending_persons

    if @trending_persons.present?
      render json: @trending_persons
    else
      render json: { error: "No trending_persons movies found" }, status: :not_found
    end
  end
end
