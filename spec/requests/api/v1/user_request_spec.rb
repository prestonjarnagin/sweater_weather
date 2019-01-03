require 'rails_helper'

RSpec.describe 'User API' do

  it 'POST /api/v1/users' do
    expect(User.all.count).to eq(0)

    post "/api/v1/forecast?location=#{location}"
    expect(response).to be_successful
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data.keys).to include(:api_key)
    expect(User.all.count).to eq(1)
  end
end
