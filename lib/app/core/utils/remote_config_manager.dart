import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';

class RemoteConfigManager {
  final FirebaseRemoteConfig _remoteConfig;

  final ValueNotifier<String> importantTaskColorNotifier = ValueNotifier('');

  RemoteConfigManager(this._remoteConfig) {
    init();
  }

  Future<void> init() async {
    await _setDefaults();
    await _setConfigSettings();
    await _fetchAndActivate();

    _remoteConfig.settings.fetchTimeout = const Duration(seconds: 10);
    _remoteConfig.settings.minimumFetchInterval = const Duration(minutes: 1);
  }

  Future<void> _setDefaults() async {
    await _remoteConfig.setDefaults({
      _ConfigFields.importantTaskColor: '#FF3B30',
    });
  }

  Future<void> _setConfigSettings() async {
    await _remoteConfig.fetchAndActivate();
  }

  Future<void> _fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
    final color = _remoteConfig.getString(_ConfigFields.importantTaskColor);
    importantTaskColorNotifier.value = color;
  }
}

abstract class _ConfigFields {
  static const importantTaskColor = 'important_task_color';
}
