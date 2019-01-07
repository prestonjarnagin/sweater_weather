class GeolocationService

  def initialize(location_query)
    @location_query = location_query
    @_get_json
  end

  def coordinates
    co = get_coordinates
    {
      lat: co[:lat],
      lng: co[:lng]
    }
  end

  def city
    address_components[0][:long_name]
  end

  def state
    address_components[2][:short_name]
  end

  private

  def conn
    Faraday.new(url:"https://maps.googleapis.com") do |faraday|
      faraday.params["key"] = ENV['GOOGLE_API_KEY']
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_coordinates
    get_json("/maps/api/geocode/json?address=#{@location_query}")[0][:geometry][:location]
  end

  def get_json(url)
    @_get_json ||= JSON.parse(conn.get(url).body, symbolize_names: true)[:results]
  end

  def address_components
    get_json("/maps/api/geocode/json?address=#{@location_query}")[0][:address_components]
  end

end
