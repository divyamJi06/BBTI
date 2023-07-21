import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/router_model.dart';
import 'package:bbti/views/passkey.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:bbti/widgets/toast.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';
import '../widgets/custom_appbar.dart';

class NewRouterInstallationPage extends StatelessWidget {
  NewRouterInstallationPage({super.key});
  StorageController _storage = StorageController();
  final TextEditingController _lockId =
      new TextEditingController(text: "BBT10100");
  final TextEditingController _ssid = new TextEditingController(text: "nandan");
  final TextEditingController _password =
      new TextEditingController(text: "nandan022");
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(heading: "Add Router")),
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
                      labelText: "Lock ID",
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                      labelText: "New Router Name",
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
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
                      labelText: "New Router Password",
                      labelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: "Submit",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        print("---------1");
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );
                        print("---------2");

                        var res = await ApiConnect.hitApiPost(
                            "$routerIP/getWifiParem", {
                          "router_ssid": _ssid.text,
                          "router_password": _password.text,
                          "lock_passkey": "Bbt@74829"
                        });
                        print("---------3");

                        print(res);
                        String IPAddr = res['IPAddress'];
                        if (IPAddr.contains("0.0.0.0")) {
                          showToast(context, "Unable to connect. Try Again.");
                          return;
                        }
                        print("---------4");

                        _storage.addRouters(RouterDetails(
                            lockID: _lockId.text,
                            name: _ssid.text,
                            password: _password.text,
                            lockPasskey: "BBT@1234",
                            iPAddress: res['IPAddress']));
                        print("---------5");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyNavigationBar()));
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
