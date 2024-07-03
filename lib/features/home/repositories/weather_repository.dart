import 'package:get/get.dart';
import 'package:zaynax_weather_forecast/features/home/models/weather_model.dart';

import '../../../core/providers/api_manager.dart';
import '../../../core/providers/api_url.dart';

class WeatherRepository {
  /// Fetches weather data for the given country name.
  Future<WeatherModel> getWeatherData(String countryName) async {
    APIManager manager = APIManager();
    String uri =
        '${ApiClient.weatherApi}$countryName+",bd&APPID="+${ApiClient.apiKey}';
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>$uri");
    final response = await manager.get(uri);

    // Assuming the response is the entire weather data object
    return WeatherModel.fromJson(response);
  }
}
