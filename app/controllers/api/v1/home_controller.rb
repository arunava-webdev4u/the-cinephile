class Api::V1::HomeController < Api::V1::ApplicationController
  def index
    render json: { message: "Welcome to The Cinephile API" }
  end
end
