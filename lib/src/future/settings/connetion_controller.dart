import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final connectionControllerVM = ChangeNotifierProvider.autoDispose<ConnectionController>((ref) {
  return ConnectionController();
});

class ConnectionController with ChangeNotifier {
  bool isDeviceConnectionEnable;
  late StreamSubscription _connectionSubscription;

  ConnectionController() : isDeviceConnectionEnable = false {
    listenDeviceConnectionEnable();
  }

  void listenDeviceConnectionEnable() {
    _connectionSubscription = InternetConnection().onStatusChange.listen((status) {
      isDeviceConnectionEnable = status == InternetStatus.connected;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
