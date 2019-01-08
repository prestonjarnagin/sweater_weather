class Api::V1::GifsController < ApplicationController

  def index
    render json: GifRender.new.build(params[:location])
  end
end
