class GeolocationService

  def initialize(location_query)
    @location_query = location_query
  end

  def coordinates
    co = get_coordinates(@location_query)
    {
      lat: co[:lat],
      lng: co[:lng]
    }
  end

  private

  def conn
    Faraday.new(url:"https://maps.googleapis.com") do |faraday|
      faraday.params["key"] = ENV['GOOGLE_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_coordinates(location)
    get_json("/maps/api/geocode/json?address=#{location}")[0][:geometry][:location]
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)[:results]
  end

end
