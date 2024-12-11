import "package:flutter/material.dart";

import "../routes/router_config.dart";
import "../../future/settings/connetion_controller.dart";
import "../../future/settings/inherted_connection_notifair.dart";
// import "../utils/utils.dart";

final ConnectionController connetionController = ConnectionController();

class AppMaterialContext extends StatelessWidget {
  const AppMaterialContext({super.key});

  @override
  Widget build(BuildContext context) => InhertedConnectionNotifair(
        connetionController: connetionController,
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              // scaffoldMessengerKey: Utils.messengerKey,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
            );
          },
        ),
      );
}
