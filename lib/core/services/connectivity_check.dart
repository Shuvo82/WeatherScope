import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityCheck {
  late BuildContext context;

  ConnectivityCheck(this.context);

  Future<bool> checkInternetConnection() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if (hasInternet) {
      return true;
    } else {
      await _showNoInternetAlert();
      return false;
    }
  }

  Future<void> _showNoInternetAlert() async {
//  BuildContext alertContext;

    await CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: "No Internet Connection",
      text: "Please check your internet connection and try again.",
      confirmBtnColor: Colors.red,
      confirmBtnText: "Retry",
      onConfirmBtnTap: () async {
        //Navigator.of(context).pop(); // Close the previous alert
        checkInternetConnection();
        //Navigator.of(context).pop(); // Close the previous alert
      },
    ).then((value) {
      context = value!;
    });
  }
}
