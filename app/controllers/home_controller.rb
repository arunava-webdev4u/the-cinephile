class HomeController < ApplicationController
  def index
    render json: { message: "Welcome to The Cinephile API" }
  end
end
