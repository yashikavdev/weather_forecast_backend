class WeathersController < ApplicationController
  def index
    weather_service = WeatherService.new(params)
    weather = weather_service.weather
    forecast = weather_service.forecast

    render json: {weather: weather, forecast: forecast}, status: :ok
  end

  def city_list
    begin
      city_list = WeatherService.fetch_city(params[:query])
      render json: city_list, status: :ok
    rescue StandardError => e
      render json: { error: e.message }, status: :internal_server_error
    end
  end
end
