import 'package:flutter/cupertino.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,

    required this.text,
    required this.onPressed,
  });

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(1, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: backGroundColour,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: backGroundColour,
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: backGroundColour,
                width: 1,
              ),
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  color: whiteColour,
                  fontWeight: FontWeight.bold),
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
    );
  }
}
