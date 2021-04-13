import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum ConnectivityStatus { wifi, mobile, offline }

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      var connectionStatus = _updateConnectionStatus(result);
      connectionStatus.then((value) => connectionStatusController.add(value));
    });
  }
  Future<ConnectivityStatus> _updateConnectionStatus(
      ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        if (await InternetConnectionChecker().hasConnection) {
          return ConnectivityStatus.wifi;
        }
        return ConnectivityStatus.offline;
      case ConnectivityResult.mobile:
        if (await InternetConnectionChecker().hasConnection) {
          return ConnectivityStatus.mobile;
        }
        return ConnectivityStatus.offline;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }
}
