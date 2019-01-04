require 'rails_helper'

RSpec.describe GifService do

  let(:subject) { GifService.new }

  it 'exists' do
    VCR.use_cassette("gif_service") do
      expect(subject).to be_a(GifService)
    end
  end

  it 'returns a random gif' do
    VCR.use_cassette("gif_service") do
      q = 'Cloudy'
      expect(subject.random_gif(q)).to include('giphy.com/gifs')
    end

  end

end
