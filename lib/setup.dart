import 'package:flutter/material.dart';

import 'src/core/server/record_server.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  RecordServer.initializeDirectory();
}
