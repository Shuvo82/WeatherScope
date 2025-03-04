import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Weather Scope',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SpinKitFadingCube(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
