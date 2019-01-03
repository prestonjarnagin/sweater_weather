class CurrentWeather
  attr_reader :time,
              :summary

  def initialize(weather_data)
    @time = weather_data[:time]
    @summary = weather_data[:summary]
    @icon = weather_data[:icon]
    @nearestStormDistance = weather_data[:nearestStormDistance]
    @nearestStormBearing = weather_data[:nearestStormBearing]
    @precipIntensity = weather_data[:precipIntensity]
    @precipProbability = weather_data[:precipProbability]
    @temperature = weather_data[:temperature]
    @apparentTemperature = weather_data[:apparentTemperature]
    @dewPoint = weather_data[:dewPoint]
    @humidity = weather_data[:humidity]
    @pressure = weather_data[:pressure]
    @windSpeed = weather_data[:windSpeed]
    @windGust = weather_data[:windGust]
    @windBearing = weather_data[:windBearing]
    @cloudCover = weather_data[:cloudCover]
    @uvIndex = weather_data[:uvIndex]
    @visibility = weather_data[:visibility]
    @ozone = weather_data[:ozone]
  end

end
