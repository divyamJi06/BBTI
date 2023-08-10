import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/constants.dart';
import 'package:bbti/controllers/apis.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../models/lock_initial.dart';
import '../widgets/custom_appbar.dart';

class PassKeyPage extends StatelessWidget {
  PassKeyPage(
      {required this.lockDetails, required this.type,super.key});
  final LockDetails lockDetails;
  final String type;
  final TextEditingController _passKey = TextEditingController();
  final StorageController _storageController = StorageController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(heading: "PassKey")),
        body: Center(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "PassKey Cannot be empty";
                      }
                      if (value.length <= 7) {
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: BorderSide(width: 40),
                      ),
                      labelText: "New Passkey",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Submit",
                    onPressed: () async {
                      await ApiConnect.hitApiPost(routerIP + "/getSecretKey", {
                        "Lock_id": lockDetails.lockld,
                        "lock_passkey": _passKey.text
                      });
                      lockDetails.lockPassKey = _passKey.text;

                      if (type == "create") {
                        _storageController.addlocks(lockDetails);
                      } else if (type == "edit") {
                        _storageController.updateLock(
                            lockDetails.lockld, lockDetails);
                      } else {
                        print("hello");
                      }
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => MyNavigationBar(),
                        ),
                        (route) =>
                            false, //if you want to disable back feature set to false
                      );
                    },
                    width: 200,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
