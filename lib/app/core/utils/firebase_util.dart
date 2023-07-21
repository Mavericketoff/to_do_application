import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../../firebase_options.dart';
import '../common/logger.dart';
import 'remote_config_manager.dart';

Future<void> initFirebase() async {
  logger.info('Firebase initialization started');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  logger
    ..info('Firebase initialized')
    ..info('Firebase Remote Config initialization started');
  final remoteConfig = FirebaseRemoteConfig.instance;
  final configManager = RemoteConfigManager(remoteConfig);
  await configManager.init();
  logger.info('Firebase Remote config initialized');
}
