require 'rails_helper'

RSpec.describe Api::V1::TvshowsController, type: :request do
    describe "GET /api/v1/tvshows/search" do
        let(:tmdb_service) { instance_double(TmdbService) }  # Mock service

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)  # Stub new instance
        end

        context "when query is present" do
            let(:query) { "Breaking Bad" }
            let(:mock_tv_shows) do
                [
                    { "id" => 123, "name" => "Breaking Bad", "overview" => "A high school teacher turns meth producer." },
                    { "id" => 456, "name" => "Breaking Bad Habbit", "overview" => "A documentary about bad habits." }
                ]
            end

            before do
                allow(tmdb_service).to receive(:search_tv_shows).with(query).and_return(mock_tv_shows)  # Mock API response
                get "/api/v1/tvshows/search", params: { query: query }
            end

            it "returns a success response" do
                expect(response).to have_http_status(:ok)
            end

            it "returns the expected TV shows" do
                json_response = JSON.parse(response.body)
                expect(json_response).to eq(mock_tv_shows)
            end
        end

        context "when query is missing" do
            before { get "/api/v1/tvshows/search" }  # No params

            it "returns a bad request status" do
                expect(response).to have_http_status(:bad_request)
            end

            it "returns an error message" do
                json_response = JSON.parse(response.body)
                expect(json_response["error"]).to eq("Query parameter is missing")
            end
        end
    end
end
