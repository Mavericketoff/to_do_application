import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/application.dart';
import 'app/core/common/enums/enviroment.dart';
import 'app/core/common/error_handler.dart';
import 'app/core/common/logger.dart';
import 'app/core/utils/firebase_util.dart';
import 'app/features/tasks/utils/api/local_storage_util.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final localStorage = LocalStorageUtil();
    await localStorage.init();
    initLogger();
    initFirebase();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    ErrorHandler.init(Environment.development);
    runApp(
      MainApp(localStorage: localStorage, environment: Environment.development),
    );
  }, ErrorHandler.recordError);
}
