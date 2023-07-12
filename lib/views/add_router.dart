import 'package:bbti/views/passkey.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

class NewRouterInstallationPage extends StatelessWidget {
  NewRouterInstallationPage({super.key});
  final TextEditingController _lockId =
      new TextEditingController(text: "BBT10100");
  final TextEditingController _ssid = new TextEditingController(text: "nandan");
  final TextEditingController _password =
      new TextEditingController(text: "nandan022");
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
                    labelText: "New Router Name",
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
                    labelText: "New Router Pass",
                    // hintText: "BBT"
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );

                        var res = await ApiConnect.hitApiPost(
                            "$routerIP/getWifiParem", {
                          "router_ssid": _ssid.text,
                          "router_password": _password.text,
                          "lock_passkey": "BBT@4321"
                        });

                        print(res);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PassKeyPage()));
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ));
  }
}
