require 'rails_helper'

RSpec.describe 'Favorites API' do
  describe 'GET' do
    describe '/api/v1/favorites' do
      it 'Succeeds' do
        user = create(:user)
        expect(user.cities).to be_empty
          payload = {
            location: 'Denver, CO',
            api_key: user.key
          }
          post "/api/v1/favorites", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
          expect(response).to be_successful
          expect(response).to have_http_status(201)
      end
    end
  end
end
