class Api::V1::SessionsController < ApplicationController

  def show
    user = User.find_by(email: params[:email])
    begin
      api_key = user.authenticate(params[:password]).key
      render :json => {:api_key => api_key}
    rescue
      render status: 400
    end
  end

end
