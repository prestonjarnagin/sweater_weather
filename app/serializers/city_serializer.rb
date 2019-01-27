class CitySerializer
  include FastJsonapi::ObjectSerializer

  set_id :name
  # attributes :weather do |object|
  #   coordinates = GeolocationService.new(object.name).coordinates
  #   weather = Weather.new(coordinates)
  #   {
  #     current: weather.current,
  #     hourly: weather.hourly,
  #     seven_day: weather.seven_day
  #   }
  # end
end
