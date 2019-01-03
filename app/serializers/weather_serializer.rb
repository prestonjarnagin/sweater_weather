class WeatherSerializer
  include FastJsonapi::ObjectSerializer

  set_id :time

  attributes :current do |object|
    object.current
  end

  attributes :seven_day do |object|
    object.seven_day
  end

  attributes :hourly do |object|
    object.hourly
  end

  attributes :flags do |object|
    "Powered by Dark Sky"
  end

end
