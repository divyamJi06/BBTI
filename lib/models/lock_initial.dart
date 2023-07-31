class LockDetails {
  late String lockld;
  late String lockSSID;
  late String lockPassword;
  late String iPAddress;
  String? lockPassKey;
  late bool isAutoLock;
  late String privatePin;

  LockDetails(
      {required this.lockld,
      this.lockPassKey,
      required this.lockSSID,
      required this.isAutoLock,
      required this.privatePin,
      required this.lockPassword,
      required this.iPAddress});

  LockDetails.fromJson(Map<String, dynamic> json) {
    lockld = json['LockId'];
    lockSSID = json['LockSSID'];
    lockPassword = json['LockPassword'];
    privatePin = json['privatePin'];
    isAutoLock = json['isAutoLock'];
    iPAddress = json['IPAddress'];
    lockPassKey = json['LockPasskey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LockId'] = lockld;
    data['LockSSID'] = lockSSID;
    data['isAutoLock'] = isAutoLock;
    data['privatePin'] = privatePin;
    data['LockPassword'] = lockPassword;
    data['IPAddress'] = iPAddress;
    data['LockPasskey'] = lockPassKey;
    return data;
  }

  String toLockQR() {
    return "$lockld,$lockSSID,$lockPassKey,$lockPassword";
  }
}
