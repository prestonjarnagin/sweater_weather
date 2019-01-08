class GifRender

  def build(location_query)
    location_service = GeolocationService.new(location_query)
    coordinates = location_service.coordinates
    @weather = Weather.new(coordinates)

    self
  end

  def to_json(container)
    container[:data] = self.data
    container[:copyright] = self.copyright
    container.to_json
  end

  def copyright
    '2018'
  end

  def data
    {daily_forecasts: self.daily_forecasts}
  end

  def daily_forecasts
    Gifs.new(@weather.seven_day).weather
  end

end
