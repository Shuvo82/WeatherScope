import 'package:get/get.dart';
import 'package:zaynax_weather_forecast/features/splash/bindings/splash_binding.dart';
import 'package:zaynax_weather_forecast/features/splash/views/splash_view.dart';

import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
