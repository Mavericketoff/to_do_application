import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../common/logger.dart';

Future<void> initCrashlytics() async {
  logger.info('Firebase Crashlytics initialization started');
  FlutterError.onError = (errorDetails) {
    logger.info('Caught error in FlutterError.onError');
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.info('Caught error in PlatforDispatcher.onError');
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  logger.info('Firebase Crashlytics initialized');
}
