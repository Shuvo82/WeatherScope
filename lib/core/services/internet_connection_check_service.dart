import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  RxInt connectionType = 0.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  Future<void> getConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult? result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        // Get.find<HomeController>().refreshHome();
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        // Get.find<HomeController>().refreshHome();
        update();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        update();
        break;
      default:
        Get.snackbar('No internet connection.',
            'Please turn on your internet connection and try again.');

        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
