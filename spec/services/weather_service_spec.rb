require 'rails_helper'

RSpec.describe WeatherService, :vcr do

  let(:subject) { WeatherService.new(39.91424689999999, -104.6002959) }

  it 'exists' do
    expect(subject).to be_a(WeatherService)
  end

  it 'returns an expected response' do
    # VCR.use_cassette("gif_service") do
    expect(subject.get_json.keys).to include(:latitude)
    expect(subject.get_json.keys).to include(:longitude)
    expect(subject.get_json.keys).to include(:timezone)
    expect(subject.get_json.keys).to include(:currently)
    expect(subject.get_json.keys).to include(:minutely)
    expect(subject.get_json.keys).to include(:hourly)
    expect(subject.get_json.keys).to include(:daily)
    expect(subject.get_json.keys).to include(:flags)
    expect(subject.get_json.keys).to include(:offset)
    # end
  end
end
