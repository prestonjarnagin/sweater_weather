# README

Sweater Weather is a micro-service wrapping the Dark Sky and Google Geolocation APIs.

### Getting Current Weather in a Location
To get a forecast for a specific location:
```
GET /api/v1/forecast?location=denver,co

--Headers--
Content-Type: application/json
Accept: application/json
```
Returns:
```
data: {
  id: 1546960225 #Time
  type: "weather"
  attributes: {
    current: {
      time:
      summary:
      icon:
      nearestStormDistance:
      nearestStormBearing:
      etc...
    }
    seven_day: {
      # Contains an array of data similar to 'current', but with additional data unique to days, such as highs and lows for each day
    }
    hourly: {
      # Contains an array of hours each containing data similar to 'current'
    }
  }
}
```
### Account Creation and Key Generation
Users can also create accounts to obtain an API key
```
POST /api/v1/users

---Headers---

Content-Type: application/json
Accept: application/json

---Body---

{
  "email": "whatever@example.com",
  "password": "password"
  "password_confirmation": "password"
}
```
This will register the user return an API key to make future requests.

To re-obtain this key, another request with the user email and password can be sent
```
POST /api/v1/sessions

---Headers---

Content-Type: application/json
Accept: application/json

---Body---

{
  "email": "whatever@example.com",
  "password": "password"
}
```

### Favorite Locations
Using the previously obtained API key, make a POST request with a location to save that location as a favorite
```
POST /api/v1/favorites

---Headers---

Content-Type: application/json
Accept: application/json

---Body---
body:

{
  "location": "Denver, CO",
  "api_key": "<API_KEY>"
}
```
This returns a 201 status with no body. The 'location' item can be typed in many different formats (city-state, just city, zip code) and will be parsed into a city, state format

To retrieve a users favorites...
```
GET /api/v1/favorites

---Headers---

Content-Type: application/json
Accept: application/json

---Body---

body:

{
  "api_key": "<API_KEY>"
}

```
Will return a list of favorite cities with current, daily, and hourly a weather forecasts for each location.

To remove a saved favorite city, send a `DELETE` request containing the saved city name **exactly** as it appears in the user favorites list.
```
DELETE /api/v1/favorites

---Headers---

Content-Type: application/json
Accept: application/json

---Body---

{
  "location": "Denver, CO",
  "api_key": "<API_KEY>"
}
```
This will remove a location from the users saved favorites and return the remaining cities on the list.


Ruby Version: 2.3.7
Rails Version 5.1.6.1

To run locally:
 * Clone down this repository
 * Run `bundle`
 * Run `rake db:{create, migrate}`
 * Run `bundle exec rspec` to run the test suite
 * Run `rails s` to start a local server on `http://localhost:3000`

Built using Darksky API and Google Geolocation API
