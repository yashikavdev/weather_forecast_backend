# app/services/weather_service.rb
class WeatherService
    include HTTParty
    base_uri ENV["OPEN_WEATHER_BASE_URL"]

    def initialize(params)
      @api_key = ENV["OPEN_WEATHER_API_KEY"]
      @lat = params[:latitude]
      @lon = params[:longitude]
    end

    def weather
      self.class.get("/weather?lat=#{@lat}&lon=#{@lon}&appid=#{@api_key}&units=metric")
    end

    def forecast
      self.class.get("/forecast?lat=#{@lat}&lon=#{@lon}&appid=#{@api_key}&units=metric")
    end

    def self.fetch_city(query)
      uri = URI.parse("#{ENV["GEO_API_URL"]}/cities?limit=10&namePrefix=#{query}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      request['X-RapidAPI-Key'] = ENV["GEO_API_KEY"]
      request['X-RapidAPI-Host'] = ENV["GEO_API_HOST"]

      response = http.request(request)

      data = JSON.parse(response.body)
      return data
    end
end
