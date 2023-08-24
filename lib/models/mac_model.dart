import 'lock_initial.dart';

class MacsDetails {
  late String name;
  late String id;
  late bool isPresentInESP;
  late LockDetails lockDetails;

  MacsDetails(
      {required this.id,
      required this.name,
      required this.isPresentInESP,
      required this.lockDetails});

  MacsDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    isPresentInESP = json['isPresentInESP'];
    lockDetails = LockDetails.fromJson(json['lockDetails']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['id'] = id;
    data['isPresentInESP'] = isPresentInESP;
    data['lockDetails'] = lockDetails.toJson();
    return data;
  }

  String toMacString() {
    return "";
  }
}
