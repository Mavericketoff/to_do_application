import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_application/app/core/utils/persistence_util.dart';

void main() {
  group('PersistenceUtil tests', () {
    late PersistenceUtil persistenceUtil;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      persistenceUtil = PersistenceUtil();
    });

    test('getTasksRevision - returns null if not set', () async {
      final revision = await persistenceUtil.getTasksRevision();
      expect(revision, isNull);
    });

    test('saveTasksRevision - saves and retrieves revision correctly',
        () async {
      const expectedRevision = 42;
      await persistenceUtil.saveTasksRevision(revision: expectedRevision);
      final retrievedRevision = await persistenceUtil.getTasksRevision();
      expect(retrievedRevision, equals(expectedRevision));
    });

    test('getDeviceId - generates and saves deviceId if not set', () async {
      final deviceId = await persistenceUtil.getDeviceId();
      expect(deviceId, isNotNull);

      final instance = await SharedPreferences.getInstance();
      final savedDeviceId = instance.getString('device_id_key');
      expect(deviceId, equals(savedDeviceId));
    });

    test('getDeviceId - returns saved deviceId if already set', () async {
      const initialDeviceId = 'initial_device_id';
      final instance = await SharedPreferences.getInstance();
      await instance.setString('device_id_key', initialDeviceId);

      final deviceId = await persistenceUtil.getDeviceId();
      expect(deviceId, equals(initialDeviceId));
    });
  });
}
