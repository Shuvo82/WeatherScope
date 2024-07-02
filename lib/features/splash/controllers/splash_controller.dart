import 'dart:async';

import 'package:get/get.dart';
import 'package:zaynax_weather_forecast/core/services/internet_connection_check_service.dart';

import '../../../core/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.HOME);
      // if (Get.find<ConnectivityController>().connectionType.value != 0) {
      //   Get.offAllNamed(Routes.HOME);
      // } else {}
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
