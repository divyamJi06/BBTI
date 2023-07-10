import 'package:bbti/constants.dart';
import 'package:bbti/controllers/apis.dart';
import 'package:bbti/controllers/permission.dart';
import 'package:bbti/views/lock_on_off.dart';
import 'package:bbti/views/newlockinstallation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

final info = NetworkInfo();

class ConnectToLockWidget extends StatefulWidget {
  const ConnectToLockWidget({Key? key}) : super(key: key);

  @override
  _ConnectToLockWidgetState createState() => _ConnectToLockWidgetState();
}

class _ConnectToLockWidgetState extends State<ConnectToLockWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityResult _connectionStatusS = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initNetworkInfo();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;

  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.wifi) {
  //     var wifiName = await (Connectivity().getWifiName());
  //     return wifiName;
  //   }
  //   // return null;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     developer.log('Couldn\'t check connectivity status', error: e);
  //     return;
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) {
  //     return Future.value(null);
  //   }

  //   return _updateConnectionStatus(result);
  // }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _initNetworkInfo();
  }

  String _connectionStatus = 'Unknown';
  final NetworkInfo _networkInfo = NetworkInfo();
  // @override
  // void initState() {
  //   super.initState();
  //   // initPlatformState();
  //   _initNetworkInfo();
  // }

  Future<void> _initNetworkInfo() async {
    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask;

    try {
      await requestPermission(Permission.nearbyWifiDevices);
      // await requestPermission(Permission.locationWhenInUse);
    } catch (e) {
      print(e.toString());
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        // ignore: deprecated_member_use
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          // ignore: deprecated_member_use
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        // ignore: deprecated_member_use
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          // ignore: deprecated_member_use
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      if (!Platform.isWindows) {
        wifiIPv6 = await _networkInfo.getWifiIPv6();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      if (!Platform.isWindows) {
        wifiSubmask = await _networkInfo.getWifiSubmask();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    try {
      if (!Platform.isWindows) {
        wifiBroadcast = await _networkInfo.getWifiBroadcast();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      if (!Platform.isWindows) {
        wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    setState(() {
      _connectionStatus = 'Wifi Name: $wifiName\n'
          'Wifi BSSID: $wifiBSSID\n'
          'Wifi IPv4: $wifiIPv4\n'
          'Wifi IPv6: $wifiIPv6\n'
          'Wifi Broadcast: $wifiBroadcast\n'
          'Wifi Gateway: $wifiGatewayIP\n'
          'Wifi Submask: $wifiSubmask\n';
    });
  }

  String _ssid = 'Unknown';

  // Future<void> initPlatformState() async {
  //   String ssid;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     ssid = await PluginWifiConnect.ssid ?? '';
  //   } on PlatformException {
  //     ssid = 'Failed to get ssid';
  //   }
  //   print(ssid);
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _ssid = ssid;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          // leading: FlutterFlowIconButton(
          //   borderColor: Colors.transparent,
          //   borderRadius: 30,
          //   borderWidth: 1,
          //   buttonSize: 60,
          //   icon: Icon(
          //     Icons.arrow_back_rounded,
          //     color: Color(0xFF101213),
          //     size: 30,
          //   ),
          //   onPressed: () async {
          //     context.pop();
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
                                'Lock Settings',
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
                      Divider(
                        height: 12,
                        thickness: 1,
                        color: Color(0xFFE0E3E7),
                      ),
                      GestureDetector(
                        onTap: () {
                          OpenSettings.openWIFISetting();
                        },
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
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
                              'OPEN WIFI SETTINGS',
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
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewInstallationPage()));
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
                              'CONNECT TO LOCK ',
                              // style:
                              // FlutterFlowTheme.of(context).bodyLarge.override(
                              //       fontFamily: 'Plus Jakarta Sans',
                              //       color: FlutterFlowTheme.of(context)
                              //           .primaryBackground,
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w500,
                              // ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text('WIFI is connected to ${_connectionStatus}'
                            // style:
                            // FlutterFlowTheme.of(context).bodyMedium.override(
                            //       fontFamily: 'Readex Pro',
                            //       fontSize: 20,
                            // ),
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
