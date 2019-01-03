require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'GET /api/v1/forecast?location=denver,co' do
    location = 'denver,co'
    get "/api/v1/forecast?location=#{location}"
    expect(response).to be_successful
  end
end
