import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do_application/app/application.dart';
import 'package:to_do_application/app/core/common/error_handler.dart';
import 'package:to_do_application/app/core/common/logger.dart';
import 'package:to_do_application/app/features/tasks/utils/api/local_storage_util.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final localStorage = LocalStorageUtil();
    await localStorage.init();
    initLogger();
    logger.info('Start main');

    ErrorHandler.init();
    runApp(
      MainApp(localStorage: localStorage),
    );
  }, ErrorHandler.recordError);
}
