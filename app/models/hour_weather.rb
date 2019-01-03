  class HourWeather

    def initialize(hourly_weather_data)
      @time = hourly_weather_data[:time]
      @summary = hourly_weather_data[:summary]
      @icon = hourly_weather_data[:icon]
      @precipIntensity = hourly_weather_data[:precipIntensity]
      @precipProbability = hourly_weather_data[:precipProbability]
      @temperature = hourly_weather_data[:temperature]
      @apparentTemperature = hourly_weather_data[:apparentTemperature]
      @dewPoint = hourly_weather_data[:dewPoint]
      @humidity = hourly_weather_data[:humidity]
      @pressure = hourly_weather_data[:pressure]
      @windSpeed = hourly_weather_data[:windSpeed]
      @windGust = hourly_weather_data[:windGust]
      @windBearing = hourly_weather_data[:windBearing]
      @cloudCover = hourly_weather_data[:cloudCover]
      @uvIndex = hourly_weather_data[:uvIndex]
      @visibility = hourly_weather_data[:visibility]
      @ozone = hourly_weather_data[:ozone]
    end
  end
