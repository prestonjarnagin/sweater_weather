class Api::V1::UsersController < ApplicationController

  def create
    begin
      User.create!(user_params)
      api_key = SecureRandom.urlsafe_base64
      # API keys should probably be hashed before
      # being saved to the database
      ## api_key = BCrypt::Password.create(api_key)
      ## => "$2a$12$K0ByB.6YI2/OYrB4fQOYLe6Tv0datUVf6VZ/2Jzwm879BW5K1cHey"
      render :json => {:api_key => api_key}, :status => 201
    rescue
      render status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
