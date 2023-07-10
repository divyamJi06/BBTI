import 'package:bbti/views/select_access.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';

// class ContactPage extends StatelessWidget {
//   const ContactPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       // bottomNavigationBar: MyNavigationBar(),
//       body: Center(
//         child: Column(
//           children: [Text("Contact")],
//         ),
//       ),
//     );
//   }
// }

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  Contact? _contact;

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
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
                              'Contacts',
                              // style: FlutterFlowTheme.of(context)
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
                    Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                        child: GestureDetector(
                          onTap: () async {
                            Contact? contact =
                                await _contactPicker.selectContact();
                            if (contact != null) {
                              print(contact.fullName);
                              print(contact.phoneNumbers);
                              print(contact);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccessRequestPage(
                                            name: contact.fullName!,
                                          )));
                            }
                            setState(() {
                              _contact = contact;
                            });
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
                              'Add Contacts',
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
                    Divider(
                      height: 12,
                      thickness: 1,
                      color: Color(0xFFE0E3E7),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Container(
                          width: 350,
                          height: 230,
                          child: new Text(
                            _contact == null
                                ? 'No contact selected.'
                                : _contact.toString(),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xEE6C43BD),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12,
                                color: Color(0xFF4B39EF),
                                offset: Offset(0, 5),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
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
    );
  }
}
