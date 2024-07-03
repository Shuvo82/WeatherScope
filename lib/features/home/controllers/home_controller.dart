import 'package:get/get.dart';
import 'package:zaynax_weather_forecast/features/home/models/weather_model.dart';
import 'package:zaynax_weather_forecast/features/home/repositories/weather_repository.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final weatherDataList = <WeatherModel>[].obs;
  final weatherDataListLoaded = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getWeatherList();
    super.onInit();
  }

  Future<void> getWeatherList() async {
    List<String>? countries = box.read<List<String>>("COUNTRIES");

    if (countries != null && countries.isNotEmpty) {
      List<WeatherModel> countryList = [];

      for (String countryName in countries) {
        try {
          WeatherModel weatherData =
              await WeatherRepository().getWeatherData(countryName);
          countryList.add(weatherData);
        } catch (e) {
          print('Failed to fetch weather data for $countryName: $e');
        }
      }

      weatherDataList.assignAll(countryList);
      weatherDataListLoaded.value = true;
    } else {
      print(
          'No countries found ! please add some countries to fetch weather data.');
    }
  }
}
