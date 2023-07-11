import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PersistenceUtil {
  static const _tasksRevisionKey = 'revision_key';
  static const _deviceIdKey = 'device_id_key';

  Future<int?> getTasksRevision() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getInt(_tasksRevisionKey);
  }

  Future<void> saveTasksRevision({required int revision}) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setInt(_tasksRevisionKey, revision);
  }

  Future<String> getDeviceId() async {
    final instance = await SharedPreferences.getInstance();
    var deviceId = instance.getString(_deviceIdKey);
    if (deviceId == null || deviceId.isEmpty) {
      deviceId = generateAndSaveDeviceId();
    }
    return deviceId;
  }

  String generateAndSaveDeviceId() {
    final deviceId = const Uuid().v4();
    SharedPreferences.getInstance().then((instance) {
      instance.setString(_deviceIdKey, deviceId);
    });
    return deviceId;
  }
}
