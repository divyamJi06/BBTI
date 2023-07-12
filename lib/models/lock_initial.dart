class LockDetails {
  late String lockld;
  late String lockSSID;
  late String lockPassword;
  late String iPAddress;
  String? lockPassKey;

  LockDetails(
      {required this.lockld,
      this.lockPassKey,
      required this.lockSSID,
      required this.lockPassword,
      required this.iPAddress});

  LockDetails.fromJson(Map<String, dynamic> json) {
    lockld = json['LockId'];
    lockSSID = json['LockSSID'];
    lockPassword = json['LockPassword'];
    iPAddress = json['IPAddress'];
    lockPassKey = json['LockPasskey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LockId'] = lockld;
    data['LockSSID'] = lockSSID;
    data['LockPassword'] = lockPassword;
    data['IPAddress'] = iPAddress;
    data['LockPasskey'] = lockPassKey;
    return data;
  }
}
