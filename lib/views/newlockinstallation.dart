import '../models/lock_initial.dart';
import 'passkey.dart';
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
                    height: 20,
                  ),
                  CustomButton(
                    width: 200,
                    text: "Submit",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );

                        await ApiConnect.hitApiPost("$routerIP/settings", {
                          "Lock_id": _lockId.text,
                          "lock_name": _ssid.text,
                          "lock_pass": _password.text
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PassKeyPage(
                                      type: "create",
                                      lockDetails: LockDetails(
                                          isAutoLock: false,
                                          privatePin: _privatePin.text,
                                          lockld: _lockId.text,
                                          lockSSID: _ssid.text,
                                          lockPassword: _password.text,
                                          iPAddress:
                                              widget.lockDetails.iPAddress),
                                    )));
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
