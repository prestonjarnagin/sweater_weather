class Api::V1::WelcomeController < ApplicationController

  def show
    render json: Directory.welcome
  end

end
