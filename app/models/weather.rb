class Weather

  def initialize(coordinates)
    @lat = coordinates[:lat]
    @lng = coordinates[:lng]
    @_current
    @_seven_day
    @_hourly
  end

  def time
    current.time
  end

  def current
    @_current ||= CurrentWeather.new(response[:currently])
  end

  def seven_day
    @_seven_day ||= begin
      forecast = response[:daily][:data]
      forecast.map do |daily_weather_data|
        DayWeather.new(daily_weather_data)
      end
    end
  end

  def hourly
    @_hourly ||= begin
      forecast = response[:hourly][:data]
      forecast.map do |hourly_weather_data|
        HourWeather.new(hourly_weather_data)
      end
    end

  end

  private

  def response
    @_response ||= service.get_json
  end

  def service
    WeatherService.new(@lat, @lng)
  end

end
