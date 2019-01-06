class Api::V1::GifsController < ApplicationController

  def index

    location_query = params[:location]
    location_service = GeolocationService.new(location_query)
    coordinates = location_service.coordinates

    weather = Weather.new(coordinates)

    weather_with_gifs = Gifs.new(weather.seven_day).weather

    response = {
      data: {
        daily_forecasts: weather_with_gifs
      },
      'copyright': 2018
    }
    render json: response
  end
end
