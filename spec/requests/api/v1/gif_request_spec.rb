require 'rails_helper'

RSpec.describe 'Giphy API' do

  it 'GET /api/v1/gifs?location=denver,co' do
    VCR.use_cassette("gif_service") do

      location = 'denver,co'
      get "/api/v1/gifs?location=#{location}"
      expect(response).to be_successful

      forecasts = JSON.parse(response.body, symbolize_names: true)[:data][:daily_forecasts]

      expect(forecasts).to be_an_instance_of(Array)
      expect(forecasts.first).to be_an_instance_of(Hash)
      expect(forecasts.first[:time]).to_not be_nil
      expect(forecasts.first[:summary]).to_not be_nil
      expect(forecasts.first[:url]).to_not be_nil

      expect(forecasts.last).to be_an_instance_of(Hash)
      expect(forecasts.last[:time]).to_not be_nil
      expect(forecasts.last[:summary]).to_not be_nil
      expect(forecasts.last[:url]).to_not be_nil
    end
  end

end
