import 'package:bbti/constants.dart';
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/views/lock_on_off.dart';
import 'package:bbti/views/qr_view.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:bbti/widgets/lock_card.dart';
import 'package:flutter/material.dart';

class LockPage extends StatelessWidget {
  const LockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 100,
        width: 100,
        child: FloatingActionButton.large(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 30,
                ),
                Text(
                  "Add Lock",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const QRViewExample(),
              ));
            }),
      ),
      appBar: AppBar(
        backgroundColor: backGroundColour,
        // automaticallyImplyLeading: false,
        title: Text(
          "Lock",
          style: TextStyle(
              color: appBarColour, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // ElevatedButton(onPressed: () {}, child: Text("Add Lock"))
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LockOnOff(
                                  IP: routerIP,
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
                      // style:
                      // FlutterFlowTheme.of(context).bodyLarge.override(
                      //       fontFamily: 'Plus Jakarta Sans',
                      //       color: FlutterFlowTheme.of(context)
                      //           .primaryBackground,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w500,
                      // ),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return LocksCard(
                        locksDetails: LockDetails(
                            iPAddress: "",
                            lockPassKey: "BBT@4321",
                            lockPassword: "BBT12121",
                            lockSSID: "BBTSSIDD",
                            lockld: "BBT10100"));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
