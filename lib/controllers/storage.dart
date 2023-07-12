import 'dart:async';
import 'dart:convert';

import 'package:bbti/models/contacts.dart';
import 'package:bbti/models/lock_initial.dart';
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

  deleteLocks() async {
    await storage.delete(key: "locks");
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
    List<ContactsModel> _model = [];
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

  Future<List<LockDetails>> readLocks() async {
    String? locks = await storage.read(key: "locks");
    List<LockDetails> _model = [];
    if (locks == null) {
      List listContectsInJson = _model.map((e) {
        return e.toJson();
      }).toList();
      storage.write(key: "locks", value: json.encode(listContectsInJson));
    } else {
      _model = [];
      var jsonContacts = json.decode(locks);
      print(jsonContacts);
      for (var element in jsonContacts) {
        _model.add(LockDetails.fromJson(element));
      }
    }
    return _model;
  }

  deleteOneLocks(LockDetails lockDetails) async {
    List<LockDetails> lockList = await readLocks();
    lockList.removeWhere((element) => element.lockld == lockDetails.lockld);
    List listContectsInJson = lockList.map((e) {
      return e.toJson();
    }).toList();
    storage.write(key: "locks", value: json.encode(listContectsInJson));
  }

  void addlocks(LockDetails lockDetails) async {
    List<LockDetails> locksList = await readLocks();
    locksList.add(lockDetails);

    List listContectsInJson = locksList.map((e) {
      return e.toJson();
    }).toList();
    storage.write(key: "locks", value: json.encode(listContectsInJson));
  }
}
