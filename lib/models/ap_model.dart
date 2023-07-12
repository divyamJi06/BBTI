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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LockId'] = this.lockID;
    data['LockSSID'] = this.lockName;
    data['LockPassword'] = this.lockPassword;
    data['IPAddress'] = this.iPAddress;
    return data;
  }
}
