class Api::V1::ForecastController < ApplicationController

  def show
    location_query = params[:location]
    location_service = GeolocationService.new(location_query)
    coordinates = location_service.coordinates
    lat = coordinates[:lat]
    lng = coordinates[:lng]
    require "pry"; binding.pry
    weather_service = WeatherService.new(lat, lng)

  end

end
