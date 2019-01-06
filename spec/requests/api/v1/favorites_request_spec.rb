require 'rails_helper'

RSpec.describe 'Favorites API' do
  describe 'GET' do
    describe '/api/v1/favorites' do
      VCR.turned_off do
        # QUESTION Why does VCR explicitly need to be turned off?
        let(:user){ create(:user) }
        let(:payload) {
          {
            location: 'Denver, CO',
            api_key: user.key
          }
        }

        before(:each) do
          # QUESTION Is there a way for to stub general requests. I'd like to have
          # one stub for all requests to maps,googleapis.com, but webmock
          # seems to require an exact path.
          stub_request(:any, "https://maps.googleapis.com/maps/api/geocode/json?address=Denver,%20CO&key=#{ENV['GOOGLE_API_KEY']}")
            .with(
             headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Faraday v0.15.4'
             })
           .to_return(status: 200, body: File.read('./spec/fixtures/denver_geolocation_response.json'), headers: {})
        end

        it 'Succeeds' do
          expect(user.cities).to be_empty
          post "/api/v1/favorites", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
          expect(response).to be_successful
          expect(response).to have_http_status(201)
        end

        it 'Can create a new resource' do
          expect(user.cities).to be_empty
          post "/api/v1/favorites", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
          expect(user.cities.length).to eq 1
          expect(user.cities.first.name).to eq 'MockDenver, CO'
        end

        it 'Fails with an incorrect key' do
          expect(user.cities).to be_empty
          payload[:api_key] = "#{payload[:api_key]}1"
          post "/api/v1/favorites", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
          expect(user.cities).to be_empty
        end

      end
    end
  end
end
