import 'package:bbti/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/apis.dart';

class LockOnOff extends StatefulWidget {
  const LockOnOff(
      {required this.IP,
      required this.lockPassKey,
      required this.lockID,
      super.key});
  final String IP;
  final String lockID;
  final String lockPassKey;
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
      appBar: PreferredSize(
        child: CustomAppBar(heading: ""),
        preferredSize: Size.fromHeight(60),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: backGroundColour),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "The status of the Lock is ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    lockStatus.toUpperCase(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  color: whiteColour, borderRadius: BorderRadius.circular(40)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {
                        try {
                          String res = await ApiConnect.hitApiGet(
                              widget.IP + "/lockstatus");
                          // ApiConnect.hitApiPost(routerIP + "/getlockCMD", {});
                          print(res);
                          if (res == "OK CLOSE") {
                            ApiConnect.hitApiPost(widget.IP + "/getlockcmd", {
                              "Lock_id": widget.lockID,
                              "lock_passkey": widget.lockPassKey,
                              "lock_cmd": "ON"
                            });
                            setState(() {
                              lockClosed = false;
                              lockStatus = "Open";
                            });
                          } else if (res == "OK OPEN") {
                            ApiConnect.hitApiPost(widget.IP + "/getlockcmd", {
                              "Lock_id": widget.lockID,
                              "lock_passkey": widget.lockPassKey,
                              "lock_cmd": "OFF"
                            });
                            setState(() {
                              lockStatus = "Closed";
                              lockClosed = true;
                            });
                          } else {
                            print("here in else");
                          }
                          print("HERE");
                          // res = await ApiConnect.hitApiGet(
                          //     widget.IP + "/lockstatus");
                          // ApiConnect.hitApiPost(routerIP + "/getlockCMD", {});
                          print(res);
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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              // spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(5, 5), // changes position of shadow
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 100,
                          child: Icon(
                            Icons.power_settings_new_outlined,
                            size: 60,
                            color: lockClosed
                                ? redButtonColour
                                : greenButtonColour,
                          ),
                          backgroundColor: lockClosed ? redColour : greenColour,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
