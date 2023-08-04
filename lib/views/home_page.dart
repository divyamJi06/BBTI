// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   // title: const Text(
      //   //   'Home Page',
      //   //   style: TextStyle(
      //   //         fontFamily: 'Outfit',
      //   //         color: Color(0xFF14181B),
      //   //         fontSize: 24,
      //   //         fontWeight: FontWeight.w500,
      //   //       ),
      //   // ),
      //   actions: [],
      //   centerTitle: false,
      //   elevation: 0,
      // ),
      body: Expanded(
  child: Container(
    width: double.infinity,
    height: 500,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4B39EF), Color(0xFFFF5963), Color(0xFFEE8B60)],
        stops: [0, 0.5, 1],
        begin: AlignmentDirectional(-1, -1),
        end: AlignmentDirectional(1, 1),
      ),
    ),
    child: Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x00FFFFFF), Colors.white],
          stops: [0, 1],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
      ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: 300,
                width: 300,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(300)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.asset("assets/images/BBT_Logo.png",fit: BoxFit.cover,))),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Transforming Technologies for tomorrow',
                      style: TextStyle(
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
