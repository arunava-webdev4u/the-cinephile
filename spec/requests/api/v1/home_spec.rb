require 'rails_helper'

RSpec.describe Api::V1::HomeController, type: :request do
    describe "GET /api/v1/home" do
        before { get "/api/v1/home", headers: { "ACCEPT" => "application/json" } }   # Runs once before all "it" test cases

        it "returns a success response" do
          expect(response).to have_http_status(:ok) # expect 200
        end

        it "returns the correct welcome message" do
          json_response = JSON.parse(response.body)
          expect(json_response["message"]).to eq("Welcome to The Cinephile API")
        end
    end
end
