import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/routes/app_pages.dart';
import 'core/services/internet_connection_check_service.dart';
import 'core/services/theme_service.dart';

initServices() async {
  Get.log('starting services ...');
  await GetStorage.init();
  await Get.putAsync<ConnectivityController>(
      () async => ConnectivityController());
  await Get.putAsync<ThemeService>(() async => ThemeService());
  Get.log('All services started...');
}

void _setInitialCountries() {
  final box = GetStorage();
  bool isFirstLaunch = box.read('isFirstLaunch') ?? true;
  if (isFirstLaunch) {
    // box.remove('COUNTRIES');
    // print('test: Setting initial countries...');
    List<String> countryList = [
      'Dhaka',
      'Tokyo',
      'London',
      'New York',
      'Paris',
      'Berlin',
      // 'Rome',
      // 'Moscow',
      // 'Madrid',
      // 'Vienna',
      // 'Amsterdam',
      // 'Brussels',
    ];
    box.write('COUNTRIES', countryList);
    box.write('isFirstLaunch', false);
    //box.write('my', "Shuvo");
  }
}

void main() async {
  await initServices();
  _setInitialCountries();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: "Zaynax Weather",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.cupertino,
          theme: Get.find<ThemeService>().getLightTheme(),
          darkTheme: Get.find<ThemeService>().getDarkTheme(),
          themeMode: Get.find<ThemeService>().getThemeMode(),
        );
      },
    ),
  );
}
