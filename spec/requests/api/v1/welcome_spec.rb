require 'rails_helper'

RSpec.describe 'Welcome' do

  describe 'GET' do
    it '/api/v1/' do
      get '/api/v1/'
      expect(response).to be_successful
      expect(response.body).to eq(File.read('./app/views/welcome.txt'))
    end
    it '/' do
      get '/'
      expect(response).to redirect_to('/api/v1/')
    end
  end
end
