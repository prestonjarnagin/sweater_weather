class Gifs

  def initialize(seven_day_weather)
    @seven_day_weather = seven_day_weather
  end

  def weather
    @seven_day_weather.each do |weather_instance|
      require "pry"; binding.pry
      response(weather_instance.summary)
    end
  end

  def conn
    Faraday.new(url: "http://api.giphy.com/v1") do |f|
      f.adapter  Faraday.default_adapter
    end
  end


  def response(search_query)
    conn.get do |req|
      req.url "/search"
      req.params['api_key'] = ENV['GIPHY_API_KEY']
      req.params['q'] = search_query
    end
  end

end
