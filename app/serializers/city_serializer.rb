class CitySerializer
  include FastJsonapi::ObjectSerializer

  set_id :name

  attributes :current_weather do |object|
    # QUESTION Is this like calling a model in the view, or is it okay?
    coordinates = GeolocationService.new(object.name).coordinates
    # TODO The model object should have lat and lng. An api call was
    # already made to get the name, and the lat, lng is thrown out
    weather = Weather.new(coordinates)
    weather.current.summary
  end
end
