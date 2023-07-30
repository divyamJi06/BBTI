import 'package:bbti/controllers/storage.dart';

import '../constants.dart';
import '../models/lock_initial.dart';
import 'apis.dart';

class RouterAddController {
  StorageController storageController = StorageController();
  Future<String?> fetchLocks(connectionStatus) async {
    print("INSIDE");
    List<LockDetails> lockDetails = await storageController.readLocks();
    print(lockDetails);
    for (var e in lockDetails) {
      if (e.lockSSID == connectionStatus) {
        // if (e.lockSSID == connectionStatus) {
        return e.lockPassKey;
      }
    }
    lockDetails.map((e) {
      print(e.lockSSID);
      print("12131");
      if (e.lockSSID == connectionStatus) {
        // if (e.lockSSID == connectionStatus) {
        return e.lockPassKey;
      }
    });
    return null;
  }
}
