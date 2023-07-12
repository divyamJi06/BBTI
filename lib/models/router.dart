class LockDetails {
  String? lockld;
  String? routerSSID;
  String? routerPassword;
  String? iPAddress;
  String? lockPassKey;

  LockDetails(
      {this.lockld,
      this.lockPassKey,
      this.routerSSID,
      this.routerPassword,
      this.iPAddress});

  LockDetails.fromJson(Map<String, dynamic> json) {
    lockld = json['LockId'];
    routerSSID = json['LockSSID'];
    routerPassword = json['LockPassword'];
    iPAddress = json['IPAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LockId'] = this.lockld;
    data['LockSSID'] = this.routerSSID;
    data['LockPassword'] = this.routerPassword;
    data['IPAddress'] = this.iPAddress;
    data['LockPasskey'] = this.lockPassKey;
    return data;
  }
}
