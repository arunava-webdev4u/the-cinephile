require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :request do
    describe "GET /api/v1/movies/search" do
        let(:tmdb_service) { instance_double(TmdbService) }  # Mock service

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)  # Stub new instance
        end

        context "when query is present" do
            let(:query) { "Avatar" }
            let(:mock_movies) do
                [
                    { "id" => 123, "name" => "Avatar", "overview" => "Jake, a paraplegic marine, replaces his brother on the Na'vi-inhabited Pandora for a corporate mission. He is accepted by the natives as one of their own, but he must decide where his loyalties lie." },
                    { "id" => 456, "name" => "Avatar 2", "overview" => "Jake Sully and Ney'tiri have formed a family and are doing everything to stay together. However, they must leave their home and explore the regions of Pandora. When an ancient threat resurfaces, Jake must fight a difficult war against the humans." }
                ]
            end

            before do
                allow(tmdb_service).to receive(:search_movies).with(query).and_return(mock_movies)  # Mock API response
                get "/api/v1/movies/search", params: { query: query }
            end

            it "returns a success response" do
                expect(response).to have_http_status(:ok)
            end

            it "returns the expected movies" do
                json_response = JSON.parse(response.body)
                expect(json_response).to eq(mock_movies)
            end
        end

        context "when query is missing" do
            before { get "/api/v1/movies/search" }  # No params

            it "returns a bad request status" do
                expect(response).to have_http_status(:bad_request)
            end

            it "returns an error message" do
                json_response = JSON.parse(response.body)
                expect(json_response["error"]).to eq("Query parameter is missing")
            end
        end
    end

    describe "GET /api/v1/movies/popular" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_movies) do
            [
                { "id" => 123, "name" => "Avatar", "overview" => "Jake, a paraplegic marine, replaces his brother on the Na'vi-inhabited Pandora for a corporate mission. He is accepted by the natives as one of their own, but he must decide where his loyalties lie." },
                { "id" => 456, "name" => "Avatar 2", "overview" => "Jake Sully and Ney'tiri have formed a family and are doing everything to stay together. However, they must leave their home and explore the regions of Pandora. When an ancient threat resurfaces, Jake must fight a difficult war against the humans." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:popular).and_return(mock_movies)
            get "/api/v1/movies/popular"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_movies)
        end
    end

    describe "GET /api/v1/movies/top_rated" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_movies) do
            [
                { "id" => 123, "name" => "Avatar", "overview" => "Jake, a paraplegic marine, replaces his brother on the Na'vi-inhabited Pandora for a corporate mission. He is accepted by the natives as one of their own, but he must decide where his loyalties lie." },
                { "id" => 456, "name" => "Avatar 2", "overview" => "Jake Sully and Ney'tiri have formed a family and are doing everything to stay together. However, they must leave their home and explore the regions of Pandora. When an ancient threat resurfaces, Jake must fight a difficult war against the humans." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:top_rated).and_return(mock_movies)
            get "/api/v1/movies/top_rated"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_movies)
        end
    end

    describe "GET /api/v1/movies/upcoming" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_movies) do
            [
                { "id" => 123, "name" => "Avatar", "overview" => "Jake, a paraplegic marine, replaces his brother on the Na'vi-inhabited Pandora for a corporate mission. He is accepted by the natives as one of their own, but he must decide where his loyalties lie." },
                { "id" => 456, "name" => "Avatar 2", "overview" => "Jake Sully and Ney'tiri have formed a family and are doing everything to stay together. However, they must leave their home and explore the regions of Pandora. When an ancient threat resurfaces, Jake must fight a difficult war against the humans." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:upcoming).and_return(mock_movies)
            get "/api/v1/movies/upcoming"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_movies)
        end
    end

    describe "GET /api/v1/movies/now_playing" do
        let(:tmdb_service) { instance_double(TmdbService) }
        let(:mock_movies) do
            [
                { "id" => 123, "name" => "Avatar", "overview" => "Jake, a paraplegic marine, replaces his brother on the Na'vi-inhabited Pandora for a corporate mission. He is accepted by the natives as one of their own, but he must decide where his loyalties lie." },
                { "id" => 456, "name" => "Avatar 2", "overview" => "Jake Sully and Ney'tiri have formed a family and are doing everything to stay together. However, they must leave their home and explore the regions of Pandora. When an ancient threat resurfaces, Jake must fight a difficult war against the humans." }
            ]
        end

        before do
            allow(TmdbService).to receive(:new).and_return(tmdb_service)
            allow(tmdb_service).to receive(:now_playing).and_return(mock_movies)
            get "/api/v1/movies/now_playing"
        end

        it "returns a success response" do
            expect(response).to have_http_status(:ok)
        end

        it "returns the popular movies" do
            json_response = JSON.parse(response.body)
            expect(json_response).to eq(mock_movies)
        end
    end
end
