import '../models/lock_initial.dart';
import 'storage.dart';

class RouterAddController {
  StorageController storageController = StorageController();
  Future<String?> fetchLocks(connectionStatus) async {
    List<LockDetails> lockDetails = await storageController.readLocks();
    for (var e in lockDetails) {
      if (e.lockSSID == connectionStatus) {
        // if (e.lockSSID == connectionStatus) {
        return e.lockPassKey;
      }
    }
    lockDetails.map((e) {
      if (e.lockSSID == connectionStatus) {
        // if (e.lockSSID == connectionStatus) {
        return e.lockPassKey;
      }
    });
    return null;
  }
}
