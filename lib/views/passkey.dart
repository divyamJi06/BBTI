import 'package:bbti/constants.dart';
import 'package:bbti/controllers/apis.dart';
import 'package:bbti/views/lock_on_off.dart';
import 'package:flutter/material.dart';

class PassKeyPage extends StatelessWidget {
  const PassKeyPage({super.key});

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
                  labelText: "New PassKey",
                  // hintText: "BBT"
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await ApiConnect.hitApiPost(routerIP + "/getSecretKey",
                        {"Lock_id": "BBT10100", "lock_passkey": "BBT@4321"});

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LockOnOff()));
                  },
                  child: Text("Submit"))
            ],
          ),
        ));
  }
}
