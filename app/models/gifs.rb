class Gifs

  def initialize(seven_day_weather)
    @seven_day_weather = seven_day_weather
  end

  def weather
    @seven_day_weather.map do |weather_instance|
      q = weather_instance.summary
      gif_url = GifService.new.random_gif(q)
      {
        time: weather_instance.time,
        summary: weather_instance.summary,
        url: gif_url
      }
    end
  end
end
