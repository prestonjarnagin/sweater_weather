require 'rails_helper'

RSpec.describe GeolocationService, :vcr do

  let(:subject) { GeolocationService.new('denver,co') }

  it 'exists' do
    # VCR.use_cassette("google_geolocation_service") do
      expect(subject).to be_a(GeolocationService)
    # end
  end

  it 'returns coordinates' do
    # VCR.use_cassette("google_geolocation_service") do
      expect(subject.coordinates[:lat].class).to be(Float)
      expect(subject.coordinates[:lng].class).to be(Float)
    # end
  end
end
