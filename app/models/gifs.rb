class Gifs

  def initialize(seven_day_weather)
    @seven_day_weather = seven_day_weather
  end

  def weather
    # Sort weather by summary so GifService can re-use
    # identical calls
    sorted = @seven_day_weather.sort_by! do |weather_instance|
      weather_instance.summary
    end

    hashed = @seven_day_weather.map do |weather_instance|
      q = weather_instance.summary
      gif_url = GifService.new.random_gif(q)
      {
        time: weather_instance.time,
        summary: weather_instance.summary,
        url: gif_url
      }
    end
    # Re-sort responses based on time
    # responses to be sorted based on time
    hashed.sort_by do |hash|
      hash[:time]
    end
  end
end
