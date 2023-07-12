import 'package:bbti/views/add_router.dart';
import 'package:bbti/views/lock_on_off.dart';
import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';
import '../constants.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColour,
        // automaticallyImplyLeading: false,
        title: Text(
          "Router",
          style: TextStyle(
              color: appBarColour, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      // bottomNavigationBar: MyNavigationBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            // ElevatedButton(onPressed: () {}, child: Text("Add Router"))
            Align(
              // alignment: AlignmentDirectional(1, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewRouterInstallationPage()));
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0x4C4B39EF),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF4B39EF),
                        width: 2,
                      ),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'Add Router',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LockOnOff(
                                IP: "http://192.168.1.20",
                                lockID: "BBT10100",
                                lockPassKey: "BBT@4321",
                                // IP: "http://192.168.28.30",
                              )));
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0x4C4B39EF),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF4B39EF),
                      width: 2,
                    ),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'LOCK ON/OFF',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
