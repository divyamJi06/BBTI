class LockDetails {
  String? lockld;
  String? lockSSID;
  int? lockPassword;
  String? iPAddress;

  LockDetails({this.lockld, this.lockSSID, this.lockPassword, this.iPAddress});

  LockDetails.fromJson(Map<String, dynamic> json) {
    lockld = json['LockId'];
    lockSSID = json['LockSSID'];
    lockPassword = json['LockPassword'];
    iPAddress = json['IPAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LockId'] = this.lockld;
    data['LockSSID'] = this.lockSSID;
    data['LockPassword'] = this.lockPassword;
    data['IPAddress'] = this.iPAddress;
    return data;
  }
}
