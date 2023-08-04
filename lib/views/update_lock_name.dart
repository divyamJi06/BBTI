import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/views/passkey.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';
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
    _lockId.text = widget.lockDetails.lockld;
    _password.text = widget.lockDetails.lockPassword;
    _ssid.text = widget.lockDetails.lockSSID;
    super.initState();
  }

  final TextEditingController _lockId = TextEditingController();

  final TextEditingController _ssid = TextEditingController();

  final TextEditingController _password = TextEditingController();
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
                  CustomButton(
                    width: 200,
                    text: "Submit",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await ApiConnect.hitApiGet(
                          routerIP + "/",
                        );
                        var data = {
                          "Lock_id": _lockId.text,
                          "lock_name": _ssid.text,
                          "lock_pass": _password.text
                        };
                        print(data);
                        await ApiConnect.hitApiPost("$routerIP/settings", data);
                        _storageController.updateLock(widget.lockDetails.lockld,
                            _lockId.text, _ssid.text, _password.text);

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
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
