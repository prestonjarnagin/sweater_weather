require 'rails_helper'

RSpec.describe 'User API' do

  describe 'POST' do
    describe '/api/v1/users' do
      let(:payload) {
        {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }

      it 'Succeeds with correct params' do
        expect(User.all.count).to eq(0)
        post "/api/v1/users", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        # post "/api/v1/users", payload
        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)
        expect(data.keys).to include(:api_key)
        expect(User.all.count).to eq(1)
      end

      it 'Fails with repeated password' do
        expect(User.all.count).to eq(0)
        payload['password_confirmation'] = 'different password'
        post "/api/v1/users", params: payload
        expect(response).to have_http_status(400)
      end

      it 'Fails when email is already in use' do
        expect(User.all.count).to eq(0)
        post "/api/v1/users", params: payload
        post "/api/v1/users", params: payload
        expect(response).to have_http_status(400)
        expect(User.all.count).to eq(1)
      end
    end

    describe '/api/v1/sessions' do
      it 'Succeeds when correct' do
        user = create(:user)
        payload = {
          email: user.email,
          password: user.password
        }
        post '/api/v1/sessions', params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:api_key]).to eq(user.key)
      end

      it 'Fails when email doesnt exist' do
        user = create(:user)
        payload = {
          email: "#{user.email}1",
          password: user.password
        }
        post '/api/v1/sessions', params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(400)
      end

      it 'Fails when password is incorrect' do
        user = create(:user)
        payload = {
          email: user.email,
          password: "#{user.password}1"
        }
        post '/api/v1/sessions', params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(400)
      end
    end
  end
end
