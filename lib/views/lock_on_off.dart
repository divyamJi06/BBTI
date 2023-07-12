import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

class LockOnOff extends StatefulWidget {
  const LockOnOff({required this.IP, super.key});
  final String IP;
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
                  try {
                    String res =
                        await ApiConnect.hitApiGet(widget.IP + "/lockstatus");
                    // ApiConnect.hitApiPost(routerIP + "/getlockCMD", {});
                    print(res);
                    if (res == "OK CLOSE") {
                      ApiConnect.hitApiPost(widget.IP + "/getlockcmd", {
                        "Lock_id": "BBT10100",
                        "lock_passkey": "BBT@4321",
                        "lock_cmd": "ON"
                      });
                    } else if (res == "OK OPEN") {
                      ApiConnect.hitApiPost(widget.IP + "/getlockcmd", {
                        "Lock_id": "BBT10100",
                        "lock_passkey": "BBT@4321",
                        "lock_cmd": "OFF"
                      });
                    } else {
                      print("here in else");
                    }
                    print("HERE");
                    res = await ApiConnect.hitApiGet(widget.IP + "/lockstatus");
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
                  } catch (e) {
                    print(e.toString());
                    final scaffold = ScaffoldMessenger.of(context);

                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text("Unable to perform"),
                        // action: SnackBarAction(
                        // label: 'UNDO',
                        // onPressed: scaffold.hideCurrentSnackBar),
                      ),
                    );
                  }
                },
                child: Text("LockOnOFF")),
            Text("The lock is " + lockStatus)
          ],
        ),
      ),
    );
  }
}
