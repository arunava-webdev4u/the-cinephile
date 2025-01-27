class TmdbService
    require 'uri'
    require 'net/http'
    require 'json'
  
    TMDB_API_KEY = ENV['TMDB_API_KEY'] # Fetch from environment variable for security
  
    def search_movies(query)
        url = URI("https://api.themoviedb.org/3/search/movie?query=#{query}&include_adult=false&language=en-US&page=1")
      
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        request["Authorization"] = 'Bearer ' + ENV['TMDB_API_READ_ACCESS_TOKEN']
    
        # Make the request and capture the response
        response = http.request(request)
        puts "============"
        p response.read_body
    
        # Parse the JSON response and return it
        JSON.parse(response.body)["results"]
    end
  end
  