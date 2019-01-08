class Api::V1::FavoritesController < ApplicationController

  def index
    begin
      cities = User.find_by(key: params[:api_key]).cities

      render json: CitySerializer.new(cities)
    rescue
      render status: 401
    end
  end

  def create
    begin
      user = User.find_by(key: params[:api_key])

      # Parse params into standard city format with geolocation service
      location = GeolocationService.new(params[:location])
      location.state
      city_state = "#{location.city}, #{location.state}"

      user.cities.find_or_create_by(name: city_state)
      render status: 201
    rescue
      render status: 401
    end
  end

  def delete
    begin
      user = User.find_by(key: params[:api_key])

      cities = user.cities
      city = cities.find_by(name: params[:location])
      city.destroy!
      render status: 200, json: CitySerializer.new(cities)
    rescue
      render status: 401
    end

  end
end
