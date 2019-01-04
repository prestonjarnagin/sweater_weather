class Api::V1::GifsController < ApplicationController

  def index

    location_query = params[:location]
    location_service = GeolocationService.new(location_query)
    coordinates = location_service.coordinates

    weather = Weather.new(coordinates)

    gifs = Gifs.new(weather.seven_day)


    render json: gifs.weather

  end

end
