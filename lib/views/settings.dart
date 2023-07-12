import 'package:bbti/controllers/storage.dart';
import 'package:bbti/views/pinpage.dart';
import 'package:flutter/material.dart';

import '../bottom_nav_bar.dart';
import '../constants.dart';
import '../controllers/apis.dart';
import 'add_mac.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       // bottomNavigationBar: MyNavigationBar(),
//       body: Center(
//         child: Column(
//           children: [Text("Settings")],
//         ),
//       ),
//     );
//   }
// }

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   style: ButtonStyle(

          //   // borderColor: Colors.transparent,
          //   // borderRadius: 30,
          //   // borderWidth: 1,
          //   // buttonSize: 60,
          //   ),
          //   icon: Icon(
          //     Icons.arrow_back_rounded,
          //     color: Color(0xFF101213),
          //     size: 30,
          //   ),
          //   onPressed: () async {

          //   },
          // ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Text(
                                'Settings',
                                // style: TextTheme.of(context)
                                //     .headlineMedium
                                //     .override(
                                //       fontFamily: 'Plus Jakarta Sans',
                                //       color: Color(0xFF101213),
                                //       fontSize: 24,
                                //       fontWeight: FontWeight.w500,
                                //     ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 12,
                        thickness: 1,
                        color: Color(0xFFE0E3E7),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PinCodeWidget()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [Color(0xFF4B39EF), Color(0x4C4B39EF)],
                                stops: [0, 1],
                                begin: AlignmentDirectional(-1, 0),
                                end: AlignmentDirectional(1, 0),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: AlignmentDirectional(0, 0),
                            child: Text(
                              'Factory Reset',
                              // style: FlutterFlowTheme.of(context)
                              //     .titleSmall
                              //     .override(
                              //       fontFamily: 'Plus Jakarta Sans',
                              //       color: Colors.white,
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
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
                            'Set AutoLock',
                            // style:
                            // FlutterFlowTheme.of(context).bodyLarge.override(
                            //       fontFamily: 'Plus Jakarta Sans',
                            //       color: Color(0xFF4B39EF),
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewMacInstallationPage()));
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
                              'Mac',
                              // style:
                              // FlutterFlowTheme.of(context).bodyLarge.override(
                              //       fontFamily: 'Plus Jakarta Sans',
                              //       color: Color(0xFF4B39EF),
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                        child: GestureDetector(
                          onTap: () async {
                            StorageController _sto = new StorageController();
                            _sto.deleteLocks();
                            // _sto.readContacts();
                            // var res = await ApiConnect.hitApiPost(
                            //     "$routerIP/deletemac", {
                            //   "MacID": _macID.text,
                            // });

                            // print(res);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             NewMacInstallationPage()));
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
                              'Mac Enable',
                              // style:
                              // FlutterFlowTheme.of(context).bodyLarge.override(
                              //       fontFamily: 'Plus Jakarta Sans',
                              //       color: Color(0xFF4B39EF),
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
