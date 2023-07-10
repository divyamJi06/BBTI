import 'package:bbti/views/lock_on_off.dart';
import 'package:bbti/views/qr_view.dart';
import 'package:flutter/material.dart';

class LockPage extends StatelessWidget {
  const LockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Lock"),

            // ElevatedButton(onPressed: () {}, child: Text("Add Lock"))
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const QRViewExample(),
                ));
              },
              child: Align(
                // alignment: AlignmentDirectional(1, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
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
                      'Add Lock',
                      // style: FlutterFlowTheme.of(context)
                      //     .bodyLarge
                      //     .override(
                      //       fontFamily: 'Plus Jakarta Sans',
                      //       color: FlutterFlowTheme.of(context)
                      //           .primaryBackground,
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LockOnOff()));
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
          ],
        ),
      ),
    );
  }
}
