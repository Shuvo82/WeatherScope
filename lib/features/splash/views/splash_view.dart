import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:zaynax_weather_forecast/core/services/connectivity_check.dart';
import 'package:zaynax_weather_forecast/features/home/views/home_view.dart';

import '../../../core/routes/app_pages.dart';
import '../../../core/services/internet_connection_check_service.dart';

class SplashView extends StatefulWidget {
  //static var routeName = '/splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );

    Get.offAllNamed(Routes.HOME);

    // bool result = await InternetConnectionChecker().hasConnection;
    // if (result == true) {
    //   Get.offAllNamed(Routes.HOME);
    // } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Zaynax Weather Forecast',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hoverColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
