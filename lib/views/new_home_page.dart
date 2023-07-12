import 'package:bbti/constants.dart';
import 'package:flutter/material.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double radius = 250;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4B39EF), Color(0xFFFF5963), Color(0xFFEE8B60)],
            stops: [0, 0.5, 1],
            begin: AlignmentDirectional(-1, -1),
            end: AlignmentDirectional(1, 1),
          ),
        ),
        child: Container(
          width: 100,
          // height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00FFFFFF), Colors.white],
              stops: [0, 1],
              begin: AlignmentDirectional(-1, 0),
              end: AlignmentDirectional(1, 1),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              // SizedBox(
              //   height: 200,
              // ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 100,
                        color: backGroundColour,
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(radius - 100),
                    border: Border.all(width: 10, color: backGroundColourDark)),
                child: Container(
                    height: radius,
                    width: radius,
                    decoration: BoxDecoration(
                        color: whiteColour,
                        borderRadius: BorderRadius.circular(radius)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: Image.asset(
                          "assets/images/BBT_Logo_2.png",
                          fit: BoxFit.fill,
                        ))),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Text(
                  'BelBird Technologies',
                  style: TextStyle(
                    color: whiteColour,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Transforming Technologies for tomorrow',
                      style: TextStyle(
                        color: backGroundColourDark,
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
              ),
            ],
          ),
        ),
      ),
    );
  }
}