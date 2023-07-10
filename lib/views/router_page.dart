import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // bottomNavigationBar: MyNavigationBar(),
      body: Center(
        child: Column(
          children: [
            Text("Router"),
            // ElevatedButton(onPressed: () {}, child: Text("Add Router"))
            Align(
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
                    'Add Router',
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
          ],
        ),
      ),
    );
  }
}
