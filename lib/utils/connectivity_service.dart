import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityServiceProvider = Provider((ref) => ConnectivityService());

class ConnectivityService {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  var isConnected = false;

  checkInternetConnection() {
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result[0] == ConnectivityResult.mobile ||
          result[0] == ConnectivityResult.wifi ||
          result[0] == ConnectivityResult.ethernet) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    });

    print("isConnected  => $isConnected");
  }
}
