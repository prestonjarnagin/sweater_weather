class Api::V1::ForecastController < ApplicationController

  def show
    location_query = params[:location]
    location_service = GeolocationService.new(location_query)
    coordinates = location_service.coordinates

    weather = Weather.new(coordinates)
    render json: WeatherSerializer.new(weather)
  end

end
