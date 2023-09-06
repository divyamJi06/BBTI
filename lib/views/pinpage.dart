import '../bottom_nav_bar.dart';
import '../controllers/apis.dart';
import '../controllers/storage.dart';
import '../models/lock_initial.dart';
import '../widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget(
      {required this.lockDetails, required this.currentLock, Key? key})
      : super(key: key);
  final String currentLock;
  final LockDetails lockDetails;
  @override
  _PinCodeWidgetState createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  TextEditingController _controller = TextEditingController();
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
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(
              heading: 'PinCode',
            )),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Enter Your Pin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                child: Text(
                  'This code helps keep your account safe and secure.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
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
                  cursorColor: const Color(0xFF4B39EF),
                  obscureText: false,
                  hintCharacter: '-',
                  controller: _controller,
                  onChanged: (_) {},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                child: CustomButton(
                  text: "Confirm",
                  width: 250,
                  onPressed: () async {
                    if (_controller.text == widget.lockDetails.privatePin) {
                      try {
                        var res = await ApiConnect.hitApiPost(
                            "${widget.lockDetails.iPAddress}/Factoryreset", {
                          "USER_DEVID": widget.lockDetails.lockld,
                          "USER_PASSKEY": widget.lockDetails.lockPassKey
                        });
                        _storageController.deleteEverythingWithRespectToLockID(
                            widget.lockDetails);
                      } catch (e) {
                        print(e.toString());
                      } finally {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNavigationBar()),
                          (route) => false,
                        );
                      }
                    } else {
                      final scaffold = ScaffoldMessenger.of(context);
                      scaffold.showSnackBar(
                        const SnackBar(
                          content: Text("Incorrect Pin"),
                        ),
                      );
                      _controller.text = "";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("You are connected to : " + widget.currentLock),
              )
            ],
          ),
        ),
      ),
    );
  }
}
