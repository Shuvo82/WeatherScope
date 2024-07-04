import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:zaynax_weather_forecast/core/providers/api_manager.dart';
import 'package:zaynax_weather_forecast/core/providers/api_url.dart';
import 'package:zaynax_weather_forecast/features/home/models/weather_model.dart';
import 'package:zaynax_weather_forecast/features/home/repositories/weather_repository.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final weatherDataList = <WeatherModel>[].obs;
  RxBool isWeatherDataListLoaded = false.obs;
  RxBool isCountryValid = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    getWeatherList();
    super.onInit();
  }

  Future getWeatherList() async {
    isWeatherDataListLoaded.value = false;
    print('test: Fetching weather data...');

    var countries = box.read('COUNTRIES');
    // print('test: countries: $countriess');
    // List<String> countries = [
    //   'Dhaka',
    //   'Tokyo',
    //   'London',
    // ];
    print('test: countries: $countries');
    if (countries != null && countries.isNotEmpty) {
      List<WeatherModel> countryList = [];

      for (String countryName in countries) {
        try {
          WeatherModel weatherData =
              await WeatherRepository().getWeatherData(countryName);
          countryList.add(weatherData);
        } catch (e) {
          Get.snackbar(
            'Error',
            'Failed to fetch weather data! $e',
            snackPosition: SnackPosition.TOP,
            backgroundColor:
                Colors.red.shade400, //Get.theme.snackBarTheme.backgroundColor,
            colorText: Colors.white,
          );
        }
      }

      weatherDataList.assignAll(countryList);
      isWeatherDataListLoaded.value = true;
      print('test: Weather data fetched successfully!');
    } else {
      Get.snackbar(
        'No countries selected',
        'Please select countries to view weather data',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  Future<void> addCountry(String countryName) async {
    if (countryName.isNotEmpty) {
      if (await countryValidationToAdd(countryName)) {
        var countries = box.read("COUNTRIES") ?? [];
        countries.add(countryName);
        box.write("COUNTRIES", countries);
        Get.snackbar(
          'Country added',
          'Weather data for $countryName will be fetched shortly',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor,
        );
        getWeatherList();
      }
    } else {
      Get.snackbar(
        'Country cannot be empty',
        'Please enter a country name',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  Future<bool> countryValidationToAdd(String countryName) async {
    var countries = box.read("COUNTRIES") ?? [];
    //Get.log('test: country to add: $countryName');
    if (countries
        .any((country) => country.toLowerCase() == countryName.toLowerCase())) {
      //Get.log('test: Country already exists');
      Get.snackbar(
        'Country already exists',
        'Please enter a different country name',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );

      return false;
    } else {
      //print("test: Fetching weather data for $countryName");
      String url =
          '${ApiClient.weatherApi}$countryName&APPID=${ApiClient.apiKey}';
      Get.log("test: API URL :$url");

      try {
        // Await the HTTP response
        http.Response response = await http.get(Uri.parse(url));
        Get.log("test: Response for $countryName");

        // Check if the response status code is 200 (OK)

        var responseJson = json.decode(response.body);

        // Check the 'cod' field in the response JSON
        if (responseJson['cod'] == 200) {
          return true; /////must be true
        } else {
          Get.snackbar(
            'Invalid country name',
            'Please enter a valid country name',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Get.theme.snackBarTheme.backgroundColor,
            colorText: Get.theme.snackBarTheme.actionTextColor,
          );
          return false;
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to fetch data. Exception: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor,
        );
        return false;
      }
    }
  }

  void removeCountry(String countryName) {
    var countries = box.read("COUNTRIES") ?? [];
    countryName = countryName
        .toLowerCase(); // Convert input to lowercase for case-insensitive comparison
    countries.removeWhere((country) => country.toLowerCase() == countryName);
    box.write("COUNTRIES", countries);
    getWeatherList();
  }

  String kelvinToCelsius(double kelvin) {
    String celsius = (kelvin - 273.15).round().toString();
    return '$celsius°C';
  }

  String kelvinToFahrenheit(double kelvin) {
    String fahrenheit = ((kelvin - 273.15) * 9 / 5 + 32).round().toString();
    return '$fahrenheit°F';
  }
}
