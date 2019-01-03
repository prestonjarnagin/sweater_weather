require 'rails_helper'

RSpec.describe 'Forecast API' do

  it 'GET /api/v1/forecast?location=denver,co' do
    VCR.use_cassette("google_geolocation_service") do
      VCR.use_cassette("darksky_service") do
        location = 'denver,co'

        get "/api/v1/forecast?location=#{location}"
        expect(response).to be_successful

        data = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
        expect(data.keys).to include(:current)
        expect(data.keys).to include(:seven_day)
        expect(data.keys).to include(:hourly)
      end
    end
  end
end
