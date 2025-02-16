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


    describe "GET /api/v1/tvshows/trending" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_tv_shows) do
            [
                { "id" => 123, "name" => "Breaking Bad", "overview" => "A high school teacher turns meth producer." },
                { "id" => 456, "name" => "Breaking Bad Habbit", "overview" => "A documentary about bad habits." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:trending_tv_shows).and_return(mock_tv_shows)
            get "/api/v1/tvshows/trending"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the trending tvshows" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_tv_shows)
        end
    end

    describe "GET /api/v1/tvshows/airing_today" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_tv_shows) do
            [
                { "id" => 123, "name" => "Breaking Bad", "overview" => "A high school teacher turns meth producer." },
                { "id" => 456, "name" => "Breaking Bad Habbit", "overview" => "A documentary about bad habits." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:airing_today).and_return(mock_tv_shows)
            get "/api/v1/tvshows/airing_today"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_tv_shows)
        end
    end

    describe "GET /api/v1/tvshows/on_the_air" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_tv_shows) do
            [
                { "id" => 123, "name" => "Breaking Bad", "overview" => "A high school teacher turns meth producer." },
                { "id" => 456, "name" => "Breaking Bad Habbit", "overview" => "A documentary about bad habits." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:on_the_air).and_return(mock_tv_shows)
            get "/api/v1/tvshows/on_the_air"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_tv_shows)
        end
    end

    describe "GET /api/v1/tvshows/popular" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_tv_shows) do
            [
                { "id" => 123, "name" => "Breaking Bad", "overview" => "A high school teacher turns meth producer." },
                { "id" => 456, "name" => "Breaking Bad Habbit", "overview" => "A documentary about bad habits." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:popular).and_return(mock_tv_shows)
            get "/api/v1/tvshows/popular"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_tv_shows)
        end
    end

    describe "GET /api/v1/tvshows/top_rated" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_tv_shows) do
            [
                { "id" => 123, "name" => "Breaking Bad", "overview" => "A high school teacher turns meth producer." },
                { "id" => 456, "name" => "Breaking Bad Habbit", "overview" => "A documentary about bad habits." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:top_rated).and_return(mock_tv_shows)
            get "/api/v1/tvshows/top_rated"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_tv_shows)
        end
    end
end
