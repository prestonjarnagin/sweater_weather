require 'rails_helper'

RSpec.describe 'Favorites API' do
  describe 'GET' do
    describe '/api/v1/favorites' do
      let(:user){ create(:user) }

      let(:payload) {
        {
          location: 'Denver, CO',
          api_key: user.key
        }
      }

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
        expect(user.cities.first.name).to eq 'Denver, CO'
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
