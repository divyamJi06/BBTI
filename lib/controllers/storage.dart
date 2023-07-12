import 'dart:async';
import 'dart:convert';

import 'package:bbti/models/contacts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  void addContacts(ContactsModel contactsModel) async {
    List<ContactsModel> contactList = await readContacts();
    contactList.add(contactsModel);

    List listContectsInJson = contactList.map((e) {
      return e.toJson();
    }).toList();
    storage.write(key: "contacts", value: json.encode(listContectsInJson));
  }

  deleteContacts() async {
    await storage.delete(key: "contacts");
  }

  deleteOneContact(ContactsModel contactsModel) async {
    List<ContactsModel> contactList = await readContacts();
    contactList.removeWhere((element) => element.name == contactsModel.name);
    // for (var element in contactList) {
    //   if(element.name == contactsModel.name){}
    // }
    // contactList.(contactsModel);
    List listContectsInJson = contactList.map((e) {
      return e.toJson();
    }).toList();
    storage.write(key: "contacts", value: json.encode(listContectsInJson));
  }

  Future<List<ContactsModel>> readContacts() async {
    String? contacts = await storage.read(key: "contacts");
    List<ContactsModel> _model = [
      // ContactsModel(
      //     accessType: "Full",
      //     date: "00-00",
      //     time: "00:00-00:00",
      //     name: "Nandan"),
      // ContactsModel(
      //     accessType: "One",
      //     date: "00-00",
      //     time: "00:00-00:00",
      //     name: "Nandan 1"),
      // ContactsModel(
      //     accessType: "Timed",
      //     date: "12-19",
      //     time: "00:00-23:23",
      //     name: "Nandan 2 "),
    ];
    if (contacts == null) {
      List listContectsInJson = _model.map((e) {
        return e.toJson();
      }).toList();
      storage.write(key: "contacts", value: json.encode(listContectsInJson));
    } else {
      _model = [];
      var jsonContacts = json.decode(contacts);
      print(jsonContacts);
      for (var element in jsonContacts) {
        _model.add(ContactsModel.fromJson(element));
      }
    }
    return _model;
  }
}
