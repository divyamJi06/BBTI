import 'package:bbti/views/passkey.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

class NewInstallationPage extends StatelessWidget {
  const NewInstallationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "LockId",
                  // hintText: "BBT"
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New SSID",
                  // hintText: "BBT"
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Pass",
                  // hintText: "BBT"
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await ApiConnect.hitApiGet(
                      routerIP + "/",
                    );

                    await ApiConnect.hitApiPost("$routerIP/settings", {
                      "Lock_id": "BBT10100",
                      "lock_name": "BBT12121",
                      "lock_pass": "BBT12121"
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PassKeyPage()));
                  },
                  child: Text("Submit"))
            ],
          ),
        ));
  }
}
