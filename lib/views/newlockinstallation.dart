
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/views/passkey.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

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

  final TextEditingController _lockId = new TextEditingController();

  final TextEditingController _ssid = new TextEditingController();

  final TextEditingController _password = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _lockId,
                  validator: (value) {
                    if (value!.length <= 0) return "Lock ID cannot be empty";
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "LockId",
                    // hintText: "BBT"
                  ),
                ),
                TextFormField(
                  controller: _ssid,
                  validator: (value) {
                    if (value!.length <= 0) return "SSID cannot be empty";
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "New SSID",
                    // hintText: "BBT"
                  ),
                ),
                TextFormField(
                  controller: _password,
                  validator: (value) {
                    if (value!.length <= 7)
                      return "Lock Password cannot be less than 8 letters";
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "New Pass",
                    // hintText: "BBT"
                  ),
                ),
                ElevatedButton(
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
                                      lockDetails: LockDetails(
                                          lockld: _lockId.text,
                                          lockSSID: _ssid.text,
                                          lockPassword: _password.text,
                                          iPAddress:
                                              widget.lockDetails.iPAddress),
                                    )));
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ));
  }
}
