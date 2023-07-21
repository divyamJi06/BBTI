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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LockId'] = this.lockID;
    data['LockSSID'] = this.name;
    data['LockPassword'] = this.password;
    data['LockPassKey'] = this.lockPasskey;
    data['IPAddress'] = this.iPAddress;
    return data;
  }
}
