class ApiClient {
  static String baseUrl = "https://api.openweathermap.org";

  static String weatherApi = "$baseUrl/data/2.5/weather?q=";
  static String apiKey = "713c5bae5a4e237d71e3afef6e075d20";
  static String iconUrl = "http://openweathermap.org/img/wn/";
}

//https://api.openweathermap.org/data/2.5/weather?q=dhaka,bd&APPID=713c5bae5a4e237d71e3afef6e075d20
//https://openweathermap.org/img/wn/09d@2x.png
//this is sample api response
Map sampleData = {
  "coord": {"lon": 90.4074, "lat": 23.7104},
  "weather": [
    {"id": 721, "main": "Haze", "description": "haze", "icon": "50d"}
  ],
  "base": "stations",
  "main": {
    "temp": 302.14,
    "feels_like": 307.65,
    "temp_min": 302.14,
    "temp_max": 302.14,
    "pressure": 1000,
    "humidity": 79,
    "sea_level": 1000,
    "grnd_level": 999
  },
  "visibility": 3500,
  "wind": {"speed": 3.09, "deg": 200},
  "clouds": {"all": 75},
  "dt": 1720008150,
  "sys": {
    "type": 1,
    "id": 9145,
    "country": "BD",
    "sunrise": 1719962134,
    "sunset": 1720010959
  },
  "timezone": 21600,
  "id": 1185241,
  "name": "Dhaka",
  "cod": 200
};
