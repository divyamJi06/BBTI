import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/constants.dart';
import 'package:bbti/controllers/apis.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/views/lock_on_off.dart';
import 'package:flutter/material.dart';

import '../models/lock_initial.dart';

class PassKeyPage extends StatelessWidget {
  PassKeyPage({required this.lockDetails, super.key});
  final LockDetails lockDetails;
  final TextEditingController _passKey = TextEditingController();
  final StorageController _storageController = new StorageController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "PassKey Cannot be empty";
                    }
                    if (value.length <=7) {
                      return "PassKey Cannot be less than 8 letters";
                    }
                    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
                    if (!validCharacters.hasMatch(value)) {
                      return "Passkey should be alphanumeric";
                    }
                    return null;
                  },
                  controller: _passKey,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "New PassKey",
                    // hintText: "BBT"
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await ApiConnect.hitApiPost(routerIP + "/getSecretKey", {
                        "Lock_id": lockDetails.lockld,
                        "lock_passkey": _passKey.text
                      });
                      lockDetails.lockPassKey = _passKey.text;
                      _storageController.addlocks(lockDetails);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNavigationBar()));
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ));
  }
}
