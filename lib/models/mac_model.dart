class MacsDetails {
  late String name;
  late String id;
  late bool isPresentInESP;

  MacsDetails({required this.id, required this.name, required this.isPresentInESP});

  MacsDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    isPresentInESP = json['isPresentInESP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['id'] = id;
    data['isPresentInESP'] = isPresentInESP;
    return data;
  }

  String toMacString() {
    return "";
  }
}
