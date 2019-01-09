require 'rails_helper'

RSpec.describe 'Favorites API' do
  around(:each) do |example|
    VCR.turned_off do
      # QUESTION Why does VCR explicitly need to be turned off?
      example.run
    end
  end
  let(:user){ create(:user) }
  let(:payload) {
        {
          location: 'Denver, CO',
          api_key: user.key
        }
      }

  describe 'POST' do
    describe '/api/v1/favorites' do
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

  describe 'GET' do

    before(:each) do
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Denver,%20CO&key=#{ENV['GOOGLE_API_KEY']}").
        with(headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
        }).
       to_return(status: 200, body: File.read('./spec/fixtures/denver_geolocation_response.json'), headers: {})

       stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/39.7392358,-104.990251").
        with(headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
        }).
        to_return(status: 200, body: File.read('./spec/fixtures/darksky_response.json'), headers: {})
    end

    describe '/api/v1/favorites' do
      it 'Succeeds' do
        user.cities.create(name: "Denver, CO")
        post_body = {
          api_key: user.key
        }
        get '/api/v1/favorites', params: post_body, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response).to be_successful
      end

      it 'Shows user favorite cities with forecast' do
        user.cities.create(name: 'Denver, CO')
        post_body = {
          api_key: user.key
        }
        get '/api/v1/favorites', params: post_body, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[0].keys).to include(:id)
        weather = data[0][:attributes][:weather]
        expect(weather.keys).to include(:current)
        expect(weather.keys).to include(:hourly)
        expect(weather.keys).to include(:seven_day)
      end

      it 'Succeeds when user has no favorites' do
        post_body = {
          api_key: user.key
        }
        get '/api/v1/favorites', params: post_body, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data).to be_empty
      end

      it 'Fails with an incorrect key' do
        user.cities.create(name: "Denver, CO")
        post_body = {
          api_key: "#{user.key}1"
        }
        get '/api/v1/favorites', params: post_body, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE' do
    describe '/api/v1/favorites' do
      it 'Succeeds' do
        user.cities.create(name: 'Denver, CO')
        post_body = {
          location: 'Denver, CO',
          api_key: user.key
        }
        delete '/api/v1/favorites', params: post_body.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it 'Succeessfully deletes resource' do
        user.cities.create(name: 'Denver, CO')
        expect(City.all.length).to eq(1)
        post_body = {
          location: 'Denver, CO',
          api_key: user.key
        }
        delete '/api/v1/favorites', params: post_body.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

        expect(City.all).to be_empty
        # QUESTION Expecting user.cities to be empty here fails
        # but checking user.cities with pry while inside the
        # controller gives the expected output.
      end

      it 'Returns remaining user favorites' do
        stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Boulder,%20CO&key=#{ENV['GOOGLE_API_KEY']}").
         with(
           headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: File.read('./spec/fixtures/boulder_geolocation_response.json'), headers: {})
         stub_request(:get, "https://api.darksky.net/forecast/#{ENV['DARKSKY_API_KEY']}/40.0149856,-105.2705456").
         with(
           headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: File.read('./spec/fixtures/darksky_response.json'), headers: {})
        user.cities.create(name: 'Denver, CO')
        user.cities.create(name: 'Boulder, CO')
        expect(City.all.length).to eq(2)

        post_body = {
          location: 'Denver, CO',
          api_key: user.key
        }
        delete '/api/v1/favorites', params: post_body.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(City.all.length).to eq(1)
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[0]).not_to be_nil
        expect(data[1]).to be_nil
      end

      it 'Fails with an incorrect key' do
        user.cities.create(name: "Denver, CO")
        post_body = {
          api_key: "#{user.key}1"
        }
        delete '/api/v1/favorites', params: post_body.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(401)
        expect(City.all.length).to eq(1)
      end
    end
  end
end
