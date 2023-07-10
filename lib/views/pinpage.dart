import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({Key? key}) : super(key: key);

  @override
  _PinCodeWidgetState createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  TextEditingController _controller = new TextEditingController();
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
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Enter Pin Code Below',
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Enter Your Pin',
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(44, 8, 44, 0),
                    child: Text(
                      'This code helps keep your account safe and secure.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                    child: PinCodeTextField(
                      autoDisposeControllers: false,
                      appContext: context,
                      length: 4,
                      // textStyle:
                      // FlutterFlowTheme.of(context).titleSmall.override(
                      //       fontFamily: 'Outfit',
                      //       color: Color(0xFF4B39EF),
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      enableActiveFill: false,
                      autoFocus: true,
                      enablePinAutofill: false,
                      errorTextSpace: 0,
                      showCursor: true,
                      cursorColor: Color(0xFF4B39EF),
                      obscureText: false,
                      hintCharacter: '-',
                      // pinTheme: PinTheme(
                      //   fieldHeight: 60,
                      //   fieldWidth: 60,
                      //   borderWidth: 2,
                      //   borderRadius: BorderRadius.circular(12),
                      //   // shape: PinCodeFieldShape.box,
                      //   activeColor: Color(0xFF4B39EF),
                      //   inactiveColor: Color(0xFFF1F4F8),
                      //   selectedColor: Color(0xFF57636C),
                      //   activeFillColor: Color(0xFF4B39EF),
                      //   inactiveFillColor: Color(0xFFF1F4F8),
                      //   selectedFillColor: Color(0xFF57636C),
                      // ),
                      controller: _controller,
                      onChanged: (_) {},
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.length == 4) {
                          return "";
                        }
                        return "Enter 4 digits";
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
              child: GestureDetector(
                onTap: () {
                  print('Button pressed ...');
                  print(_controller.text);
                },
                child: Text('Confirm & Continue'),
                // options: FFButtonOptions(
                //   width: 270,
                //   height: 50,
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                //   iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                //   color: Color(0xFF101213),
                //   textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                //         fontFamily: 'Outfit',
                //         color: Color(0xFFF1F4F8),
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //       ),
                //   elevation: 2,
                //   borderSide: BorderSide(
                //     color: Colors.transparent,
                //     width: 1,
                //   ),
                //   borderRadius: BorderRadius.circular(12),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
