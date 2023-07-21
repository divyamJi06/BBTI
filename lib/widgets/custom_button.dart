import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.width,
    this.bgmColor,
    required this.text,
    required this.onPressed,
  });

  final String text;
  double? width = 300;
  Color? bgmColor = backGroundColour;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      // alignment: AlignmentDirectional(1, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
        child: InkWell(
          splashColor: bgmColor,
          onTap: onPressed,
          child: Container(
            width: width,
            height: 50,
            decoration: BoxDecoration(
              color: bgmColor ?? backGroundColour,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: bgmColor ?? backGroundColour,
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: bgmColor ?? backGroundColour,
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
            ),
          ),
        ),
      ),
    );
  }
}
