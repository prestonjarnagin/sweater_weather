require 'rails_helper'

RSpec.describe 'Giphy API', :vcr do

  it 'GET /api/v1/gifs?location=denver,co' do
    # VCR.use_cassette("gif_feature") do
      location = 'denver,co'
      get "/api/v1/gifs?location=#{location}"
      expect(response).to be_successful
      forecasts = JSON.parse(response.body, symbolize_names: true)[:data][:daily_forecasts]

      expect(forecasts).to be_an_instance_of(Array)
      expect(forecasts).to all(be_an_instance_of(Hash))
      expect(forecasts).to all(include(:time))
      expect(forecasts).to all(include(:summary))
      expect(forecasts).to all(include(:url))
    # end
  end
end
