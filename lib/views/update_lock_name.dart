import 'package:bbti/widgets/toast.dart';

import '../bottom_nav_bar.dart';
import '../controllers/storage.dart';
import '../models/lock_initial.dart';
import '../widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../controllers/apis.dart';
import '../widgets/custom_appbar.dart';

class UpdateLockInstallationPage extends StatefulWidget {
  UpdateLockInstallationPage({required this.lockDetails, super.key});

  final LockDetails lockDetails;

  @override
  State<UpdateLockInstallationPage> createState() =>
      _UpdateLockInstallationPageState();
}

class _UpdateLockInstallationPageState
    extends State<UpdateLockInstallationPage> {
  @override
  void initState() {
    // TODO: implement initState
    _password.text = widget.lockDetails.lockPassword;
    _password1.text = widget.lockDetails.lockPassword;
    _ssid.text = widget.lockDetails.lockSSID;
    super.initState();
  }

  // final TextEditingController _lockId = TextEditingController();

  final TextEditingController _ssid = TextEditingController();
  final TextEditingController _passKey = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _privatePin = TextEditingController();
  StorageController _storageController = new StorageController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(heading: "AP Updation")),
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
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
                      if (value!.length <= 7)
                        return "Lock Password cannot be less than 8 letters";
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
                    controller: _password1,
                    validator: (value) {
                      if (value!.length <= 7)
                        return "Lock Password cannot be less than 8 letters";
                      if (_password.text != _password1.text)
                        return "Passwords do not match";
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
                      labelText: "Enter Pin",
                      labelStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                    width: 200,
                    text: "Submit",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        if (_passKey.text != widget.lockDetails.lockPassKey) {
                          showToast(context,
                              "Passkey of the lock is incorrect. Try Again.");
                          return;
                        }
                        if (_privatePin.text != widget.lockDetails.privatePin) {
                          showToast(context,
                              "Private Pin of the lock is incorrect. Try Again.");
                          return;
                        }
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );
                        var data = {
                          "Lock_id": widget.lockDetails.lockld,
                          "lock_name": _ssid.text,
                          "lock_pass": _password.text
                        };
                        print(data);
                        await ApiConnect.hitApiPost("$routerIP/settings", data);
                        LockDetails lockDetails1 = LockDetails(
                            isAutoLock: widget.lockDetails.isAutoLock,
                            privatePin: widget.lockDetails.privatePin,
                            lockld: widget.lockDetails.lockld,
                            lockSSID: _ssid.text,
                            lockPassKey: _passKey.text,
                            lockPassword: _password.text,
                            iPAddress: widget.lockDetails.iPAddress);

                        await ApiConnect.hitApiPost("$routerIP/getSecretKey", {
                          "Lock_id": lockDetails1.lockld,
                          "lock_passkey": _passKey.text
                        });
                        _storageController.updateLock(
                            lockDetails1.lockld, lockDetails1);
                        Navigator.pushAndRemoveUntil<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                MyNavigationBar(),
                          ),
                          (route) => false,
                        );
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
