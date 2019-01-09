class Api::V1::ForecastController < ApplicationController

  def show
    location_service = GeolocationService.new(params[:location])
    coordinates = location_service.coordinates

    weather = Weather.new(coordinates)
    render json: WeatherSerializer.new(weather)
  end

end
