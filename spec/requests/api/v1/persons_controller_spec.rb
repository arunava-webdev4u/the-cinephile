require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
  describe "GET /api/v1/persons/search" do
    let(:tmdb_service) { instance_double(TmdbService) }  # Mock service

    before do
      allow(TmdbService).to receive(:new).and_return(tmdb_service)  # Stub new instance
    end

    context "when query is present" do
      let(:query) { "tom+cruise" }
      let(:mock_persons) do
        [
          { "id" => 123, "name" => "Tom Cruise", "overview" => "Known for Mission Impossible" },
          { "id" => 456, "name" => "Tom Hiddleson", "overview" => "Known for Marvel Movies" }
        ]
      end

      before do
        allow(tmdb_service).to receive(:search_persons).with(query).and_return(mock_persons)  # Mock API response
        get "/api/v1/persons/search", params: { query: query }
      end

      it "returns a success response" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the expected movies" do
        json_response = JSON.parse(response.body)
        expect(json_response).to eq(mock_persons)
      end
    end

    context "when query is missing" do
      before { get "/api/v1/persons/search" }  # No params

      it "returns a bad request status" do
        expect(response).to have_http_status(:bad_request)
      end

      it "returns an error message" do
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Query parameter is missing")
      end
    end
  end

  describe "GET /api/v1/persons/trending" do
    let(:tmdb_service) { instance_double(TmdbService) }
    let(:mock_persons) do
      [
        { "id" => 123, "name" => "Tom Cruise", "overview" => "Known for Mission Impossible" },
        { "id" => 456, "name" => "Tom Hiddleson", "overview" => "Known for Marvel Movies" }
      ]
    end

    before do
        allow(TmdbService).to receive(:new).and_return(tmdb_service)
        allow(tmdb_service).to receive(:trending_persons).and_return(mock_persons)
        get "/api/v1/persons/trending"
    end

    it "returns a success response" do
        expect(response).to have_http_status(:ok)
    end

    it "returns the trending persons" do
        json_response = JSON.parse(response.body)
        expect(json_response).to eq(mock_persons)
    end
end
end
