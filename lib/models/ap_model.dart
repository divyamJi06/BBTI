class APMode {
  late String lockID;
  late String lockName;
  late String lockPassword;
  late String iPAddress;
  late String lockPasskey;

  APMode(
      {required this.lockID,
      required this.lockName,
      required this.lockPassword,
      required this.iPAddress,
      required this.lockPasskey});

  APMode.fromJson(Map<String, dynamic> json) {
    lockID = json['LockId'];
    lockName = json['LockSSID'];
    lockPassword = json['LockPassword'];
    lockPasskey = json['LockPassKey'];
    iPAddress = json['IPAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LockId'] = lockID;
    data['LockSSID'] = lockName;
    data['LockPassword'] = lockPassword;
    data['IPAddress'] = iPAddress;
    return data;
  }
}
