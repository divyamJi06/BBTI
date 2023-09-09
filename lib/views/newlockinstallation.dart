import '../bottom_nav_bar.dart';
import '../controllers/storage.dart';
import '../models/lock_initial.dart';
import '../widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';
import '../widgets/custom_appbar.dart';

class NewInstallationPage extends StatefulWidget {
  NewInstallationPage({required this.lockDetails, super.key});

  final LockDetails lockDetails;

  @override
  State<NewInstallationPage> createState() => _NewInstallationPageState();
}

class _NewInstallationPageState extends State<NewInstallationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController _lockId = TextEditingController();
  final TextEditingController _passKey = TextEditingController();
  final StorageController _storageController = StorageController();
  final TextEditingController _ssid = TextEditingController();

  final TextEditingController _password = TextEditingController();
  final TextEditingController _privatePin = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(heading: "New AP Installation")),
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _lockId,
                    validator: (value) {
                      if (value!.length <= 0) return "Lock ID cannot be empty";
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: BorderSide(width: 40),
                      ),
                      labelText: "LockID",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: _ssid,
                    validator: (value) {
                      if (value!.length <= 0) return "SSID cannot be empty";
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: BorderSide(width: 40),
                      ),
                      labelText: "New Lock Name",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _password,
                    validator: (value) {
                      if (value!.length <= 7) {
                        return "Lock Password cannot be less than 8 letters";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: BorderSide(width: 40),
                      ),
                      labelText: "New Password",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 4,
                    controller: _privatePin,
                    validator: (value) {
                      if (value!.length <= 3) {
                        return "Lock Pin cannot be less than 4 letters";
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        // borderSide: BorderSide(width: 40),
                      ),
                      labelText: "New Pin",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
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
                      if (validCharacters.hasMatch(value)) {
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
                    width: 200,
                    text: "Submit",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        LockDetails lockDetails = LockDetails(
                            isAutoLock: false,
                            privatePin: _privatePin.text,
                            lockld: _lockId.text,
                            lockSSID: _ssid.text,
                            lockPassKey: _passKey.text,
                            lockPassword: _password.text,
                            iPAddress: widget.lockDetails.iPAddress);
                        try {
                          await ApiConnect.hitApiGet(
                            routerIP + "/",
                          );

                          await ApiConnect.hitApiPost("$routerIP/settings", {
                            "Lock_id": _lockId.text,
                            "lock_name": _ssid.text,
                            "lock_pass": _password.text
                          });
                          await ApiConnect.hitApiGet(
                            routerIP + "/",
                          );

                          await ApiConnect.hitApiPost(
                              routerIP + "/getSecretKey", {
                            "Lock_id": lockDetails.lockld,
                            "lock_passkey": _passKey.text
                          });
                          _storageController.addlocks(lockDetails);
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  MyNavigationBar(),
                            ),
                            (route) =>
                                false, //if you want to disable back feature set to false
                          );
                        } catch (e) {
                          await ApiConnect.hitApiGet(
                            routerIP + "/",
                          );

                          await ApiConnect.hitApiPost(
                              routerIP + "/getSecretKey", {
                            "Lock_id": lockDetails.lockld,
                            "lock_passkey": _passKey.text
                          });
                          _storageController.addlocks(lockDetails);
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  MyNavigationBar(),
                            ),
                            (route) =>
                                false, //if you want to disable back feature set to false
                          );
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
