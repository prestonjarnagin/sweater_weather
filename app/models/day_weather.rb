class DayWeather
  attr_reader :summary

  def initialize(weather_data)
    @time = weather_data[:time]
    @summary = weather_data[:summary]
    @icon = weather_data[:icon]
    @sunriseTime = weather_data[:sunriseTime]
    @sunsetTime = weather_data[:sunsetTime]
    @moonPhase = weather_data[:moonPhase]
    @precipIntensity = weather_data[:precipIntensity]
    @precipIntensityMax = weather_data[:precipIntensityMax]
    @precipIntensityMaxTime = weather_data[:precipIntensityMaxTime]
    @precipProbability = weather_data[:precipProbability]
    @precipAccumulation = weather_data[:precipAccumulation]
    @precipType = weather_data[:precipType]
    @temperatureHigh = weather_data[:temperatureHigh]
    @temperatureHighTime = weather_data[:temperatureHighTime]
    @temperatureLow = weather_data[:temperatureLow]
    @temperatureLowTime = weather_data[:temperatureLowTime]
    @apparentTemperatureHigh = weather_data[:apparentTemperatureHigh]
    @apparentTemperatureHighTime = weather_data[:apparentTemperatureHighTime]
    @apparentTemperatureLow = weather_data[:apparentTemperatureLow]
    @apparentTemperatureLowTime = weather_data[:apparentTemperatureLowTime]
    @dewPoint = weather_data[:dewPoint]
    @humidity = weather_data[:humidity]
    @pressure = weather_data[:pressure]
    @windSpeed = weather_data[:windSpeed]
    @windGust = weather_data[:windGust]
    @windGustTime = weather_data[:windGustTime]
    @windBearing = weather_data[:windBearing]
    @cloudCover = weather_data[:cloudCover]
    @uvIndex = weather_data[:uvIndex]
    @uvIndexTime = weather_data[:uvIndexTime]
    @visibility = weather_data[:visibility]
    @ozone = weather_data[:ozone]
    @temperatureMin = weather_data[:temperatureMin]
    @temperatureMinTime = weather_data[:temperatureMinTime]
    @temperatureMax = weather_data[:temperatureMax]
    @temperatureMaxTime = weather_data[:temperatureMaxTime]
    @apparentTemperatureMin = weather_data[:apparentTemperatureMin]
    @apparentTemperatureMinTime = weather_data[:apparentTemperatureMinTime]
    @apparentTemperatureMax = weather_data[:apparentTemperatureMax]
    @apparentTemperatureMaxTime = weather_data[:apparentTemperatureMaxTime]
  end

end
