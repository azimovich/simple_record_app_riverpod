import "package:flutter/material.dart";

import "../routes/router_config.dart";
// import "../utils/utils.dart";

class AppMaterialContext extends StatelessWidget {
  const AppMaterialContext({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        // scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      );
}
