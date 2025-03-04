import 'package:get/get.dart';

import '../../../core/api_controller/api_manager.dart';
import '../../../core/api_controller/api_url.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  /// Fetches weather data for the given country name.
  Future<WeatherModel> getWeatherData(String countryName) async {
    APIManager manager = APIManager();
    print("test: Fetching weather data for $countryName");
    String uri =
        '${ApiClient.weatherApi}$countryName&APPID=${ApiClient.apiKey}';
    print("test: API URL :$uri");
    final response = await manager.get(uri);

    // Assuming the response is the entire weather data object
    print("test: Response for $countryName: $response");
    return WeatherModel.fromJson(response);
  }
  
}
