require 'rails_helper'

RSpec.describe 'Giphy API' do

  it 'GET /api/v1/gifs?location=denver,co' do
    location = 'denver,co'
    get "/api/v1/gifs?location=#{location}"
    expect(response).to be_successful

    forecasts = JSON.parse(response.body, symbolize_names: true)[:data][:daily_forecasts]
    
    expect(forecasts).to be_an_instance_of(Array)
    expect(forecasts.first).to be_an_instance_of(Hash)
    expect(forecasts.first[:time]).to exist
    expect(forecasts.first[:summary]).to exist
    expect(forecasts.first[:url]).to exist

    expect(forecasts.last).to be_an_instance_of(Hash)
    expect(forecasts.last[:time]).to exist
    expect(forecasts.last[:summary]).to exist
    expect(forecasts.last[:url]).to exist

  end

end
