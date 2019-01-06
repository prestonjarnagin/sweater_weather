class Api::V1::FavoritesController < ApplicationController

  def create
    begin
      user = User.find_by(key: params[:api_key])
      user.cities.find_or_create_by(name: params[:location])
      render status: 201
    rescue
      render status: 401
    end
  end

end
