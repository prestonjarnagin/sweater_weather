require 'rails_helper'

RSpec.describe 'User API' do

  it 'POST /api/v1/users succeeds' do
    expect(User.all.count).to eq(0)

    payload = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: payload

    expect(response).to be_successful
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data.keys).to include(:api_key)
    expect(User.all.count).to eq(1)
  end
end
