class ApplicationController < ActionController::API

  def current_user
    User.find_by(key: params[:api_key])
  end
end
