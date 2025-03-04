import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:get_storage/get_storage.dart';

import '../../../core/api_controller/api_url.dart';
import '../models/weather_model.dart';
import '../repositories/weather_repository.dart';

class HomeController extends GetxController {
  final weatherDataList = <WeatherModel>[].obs;
  RxBool isWeatherDataListLoaded = false.obs;
  RxBool isCityListEmpty = false.obs;
  RxBool isCountryValid = false.obs;
  final box = GetStorage();

  @override
  Future<void> onInit() async {
    checkInternetConnection();
    getWeatherList();
    super.onInit();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.vpn) {
      //Get.log('test: No Internet connection available');
    } else {
      Get.snackbar(
        'No Internet Connection',
        'Please check your internet connection and try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Colors.red,
      );
    }
  }

  Future getWeatherList() async {
    isWeatherDataListLoaded.value = false;
    //isCityListEmpty.value = false;
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
            'Failed to fetch weather data! ',
            snackPosition: SnackPosition.TOP,
            backgroundColor:
                Colors.red.shade400, //Get.theme.snackBarTheme.backgroundColor,
            colorText: Colors.white,
          );
          break;
        }
      }

      weatherDataList.assignAll(countryList);
      isWeatherDataListLoaded.value = true;
      print('test: Weather data fetched successfully!');
    } else {
      isCityListEmpty.value = true;
      Get.snackbar(
        'No countries selected',
        'Please select countries to view weather data',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Colors.white,
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
          colorText: Colors.white,
        );
        getWeatherList();
      }
    } else {
      Get.snackbar(
        'Country cannot be empty',
        'Please enter a country name',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Colors.white,
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
        colorText: Colors.white,
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
            colorText: Colors.white,
          );
          return false;
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          ' Something went wrong! Failed to add country.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Colors.redAccent,
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
    return '$celsius° C';
  }

  String kelvinToFahrenheit(double kelvin) {
    String fahrenheit = ((kelvin - 273.15) * 9 / 5 + 32).round().toString();
    return '$fahrenheit° F';
  }
}
