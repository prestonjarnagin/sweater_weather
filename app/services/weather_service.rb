class WeatherService

  def initialize(lat, lng)
    @lat = lat
    @lng = lng
  end

  def get_json
    JSON.parse(response.body, symbolize_names: true)
  end

  def response
    conn.get
  end

  def conn
    Faraday.new("https://api.darksky.net/forecast/#{key}/#{@lat},#{@lng}")
  end

  def key
    ENV['DARKSKY_API_KEY']
  end
end
