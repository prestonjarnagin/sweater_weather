class Gifs

  def initialize(seven_day_weather)
    @seven_day_weather = seven_day_weather
  end

  def weather
    @seven_day_weather.map do |weather_instance|
      {
        time: weather_instance.time,
        summary: weather_instance.summary,
        url: random_gif(weather_instance.summary)
      }
    end
  end

  def conn
    Faraday.new(url: "http://api.giphy.com") do |f|
      f.adapter  Faraday.default_adapter
    end
  end

  def response(search_query)
    conn.get do |req|
      req.url "/v1/gifs/search"
      req.params['api_key'] = ENV['GIPHY_API_KEY']
      req.params['q'] = search_query
    end
  end

  def get_json(search_query)
    JSON.parse(response(search_query).body, symbolize_names: true)
  end

  def random_gif(search_query)
    get_json(search_query)[:data].sample[:url]
  end

end
