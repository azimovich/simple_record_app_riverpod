import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connetion_controller.dart';

class ConnectionListener extends ConsumerWidget {
  final Widget child;

  // ignore: use_super_parameters
  const ConnectionListener({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionController = ref.watch(connectionControllerVM);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!connectionController.isDeviceConnectionEnable && !connectionDialogIsOpen) {
        showDialogIfNotConnected(context);
      } else if (connectionController.isDeviceConnectionEnable && connectionDialogIsOpen) {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        connectionDialogIsOpen = false;
      }
    });

    return child;
  }

  void showDialogIfNotConnected(BuildContext context) {
    connectionDialogIsOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.white,
          content: Text(
            "Internetda sifati yomonlashgani sababli siz tarmoqdan uzildinggiz!\nIltimos qurilma internet ulagnlab ekanligini tekshiring.",
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

bool connectionDialogIsOpen = false;
