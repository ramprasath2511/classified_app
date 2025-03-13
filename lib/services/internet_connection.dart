import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';


class InternetConnection {
  InternetConnection._();

  static Future<bool> checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult[0] == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult[0] == ConnectivityResult.wifi) {
      return true;
    } if (connectivityResult[0] == ConnectivityResult.ethernet) {
      return true;
    } else if (connectivityResult[0] == ConnectivityResult.none) {
      displayToastMessage("Please check your internet connection!");
      return false;
    } else {
      return false;
    }
  }

  static displayToastMessage(String? message) {
    Fluttertoast.showToast(msg: message!);
  }
}
