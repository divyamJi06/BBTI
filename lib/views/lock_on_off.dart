import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

class LockOnOff extends StatefulWidget {
  const LockOnOff({super.key});

  @override
  State<LockOnOff> createState() => _LockOnOffState();
}

class _LockOnOffState extends State<LockOnOff> {
  String lockStatus = "Closed";
  bool lockClosed = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  String res =
                      await ApiConnect.hitApiGet(routerIP + "/lockstatus");
                  // ApiConnect.hitApiPost(routerIP + "/getlockCMD", {});
                  print(res);
                  if (res == "OK CLOSE") {
                    ApiConnect.hitApiPost(routerIP + "/getlockcmd", {
                      "Lock_id": "BBT10100",
                      "lock_passkey": "BBT@4321",
                      "lock_cmd": "ON"
                    });
                  } else if (res == "OK OPEN") {
                    ApiConnect.hitApiPost(routerIP + "/getlockcmd", {
                      "Lock_id": "BBT10100",
                      "lock_passkey": "BBT@4321",
                      "lock_cmd": "OFF"
                    });
                  } else {
                    print("here in else");
                  }
                  print("HERE");
                  res = await ApiConnect.hitApiGet(routerIP + "/lockstatus");
                  // ApiConnect.hitApiPost(routerIP + "/getlockCMD", {});
                  print(res);
                  if (res == "OK CLOSE") {
                    setState(() {
                      lockStatus = "Open";
                    });
                  } else {
                    setState(() {
                      lockStatus = "Closed";
                    });
                  }
                },
                child: Text("LockOnOFF")),
            Text(lockStatus)
          ],
        ),
      ),
    );
  }
}
