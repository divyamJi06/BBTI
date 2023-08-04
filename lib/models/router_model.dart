class RouterDetails {
  late String lockID;
  late String name;
  late String password;
  late String? iPAddress;
  late String lockPasskey;

  RouterDetails(
      {required this.lockID,
      required this.name,
      required this.password,
      this.iPAddress,
      required this.lockPasskey});

  RouterDetails.fromJson(Map<String, dynamic> json) {
    lockID = json['LockId'];
    name = json['LockSSID'];
    password = json['LockPassword'];
    lockPasskey = json['LockPassKey'];
    iPAddress = json['IPAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LockId'] = lockID;
    data['LockSSID'] = name;
    data['LockPassword'] = password;
    data['LockPassKey'] = lockPasskey;
    data['IPAddress'] = iPAddress;
    return data;
  }

  String toRouterQR() {
    return "$lockID,$name,$password,$lockPasskey,$iPAddress";
  }
}
