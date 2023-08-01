import 'package:bbti/bottom_nav_bar.dart';
import 'package:bbti/constants.dart';
import 'package:bbti/controllers/apis.dart';
import 'package:bbti/controllers/storage.dart';
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_appbar.dart';

class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({required this.lockDetails, Key? key}) : super(key: key);
  final LockDetails lockDetails;
  @override
  _PinCodeWidgetState createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  TextEditingController _controller = new TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  StorageController _storageController = StorageController();
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: CustomAppBar(
              heading: 'PinCode',
            )),
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Enter Your Pin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                child: Text(
                  'This code helps keep your account safe and secure.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  appContext: context,
                  length: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  enableActiveFill: false,
                  autoFocus: true,
                  enablePinAutofill: false,
                  errorTextSpace: 0,
                  showCursor: true,
                  cursorColor: Color(0xFF4B39EF),
                  obscureText: false,
                  hintCharacter: '-',
                  controller: _controller,
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                child: CustomButton(
                  text: "Confirm",
                  width: 250,
                  onPressed: () async {
                    if (_controller.text == widget.lockDetails.privatePin) {
                      var res = await ApiConnect.hitApiPost(
                          "${widget.lockDetails.iPAddress}/Factoryreset", {
                        "USER_DEVID": widget.lockDetails.lockld,
                        "USER_PASSKEY": widget.lockDetails.lockPassKey
                      });

                      print(res.toString());
                      _storageController.deleteOneLock(widget.lockDetails);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNavigationBar()));
                    } else {
                      final scaffold = ScaffoldMessenger.of(context);

                      scaffold.showSnackBar(
                        SnackBar(
                          content: Text("Incorrect Pin"),
                        ),
                      );
                      _controller.text = "";
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
