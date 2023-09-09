import 'dart:async';
import 'dart:developer' as developer;
import '../controllers/storage.dart';
import '../models/lock_initial.dart';
import '../views/update_lock_name.dart';
import 'toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../bottom_nav_bar.dart';
import '../constants.dart';
import '../controllers/apis.dart';
import '../controllers/permission.dart';

class LocksCard extends StatefulWidget {
  final LockDetails locksDetails;
  LocksCard({
    required this.locksDetails,
    super.key,
  });

  @override
  State<LocksCard> createState() => _LocksCardState();
}

class _LocksCardState extends State<LocksCard> {
  StorageController _storageController = StorageController();
  bool hide = true;
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

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _initNetworkInfo();
  }

  String _connectionStatus = 'Unknown';
  final NetworkInfo _networkInfo = NetworkInfo();
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
      _connectionStatus = wifiName!.toString();
      // 'Wifi BSSID: $wifiBSSID\n'
      // 'Wifi IPv4: $wifiIPv4\n'
      // 'Wifi IPv6: $wifiIPv6\n'
      // 'Wifi Broadcast: $wifiBroadcast\n'
      // 'Wifi Gateway: $wifiGatewayIP\n'
      // 'Wifi Submask: $wifiSubmask\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          // height: 150,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(5, 5), // changes position of shadow
            ),
          ], color: whiteColour, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Lock ID : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        widget.locksDetails.lockld,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Lock Name : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        widget.locksDetails.lockSSID,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Lock PassKey : ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        hide
                            ? List.generate(
                                widget.locksDetails.lockPassKey!.length,
                                (index) => "*").join()
                            : widget.locksDetails.lockPassKey!,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Lock Password: ",
                      style: TextStyle(
                          fontSize: 20,
                          color: blackColour,
                          fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Text(
                        hide
                            ? List.generate(
                                widget.locksDetails.lockPassword.length,
                                (index) => "*").join()
                            : widget.locksDetails.lockPassword,
                        style: TextStyle(
                            fontSize: 20,
                            color: blackColour,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: backGroundColour,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          tooltip: "Delete Lock",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (cont) {
                                  return AlertDialog(
                                    title: const Text('BBT Lock'),
                                    content:
                                        const Text('This will delete the Lock'),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('CANCEL'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          _storageController.deleteOneLock(
                                              widget.locksDetails);
                                          Navigator.pushAndRemoveUntil<dynamic>(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                              builder: (BuildContext context) =>
                                                  MyNavigationBar(),
                                            ),
                                            (route) =>
                                                false, //if you want to disable back feature set to false
                                          );
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete)),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          tooltip: "Refresh Lock",
                          onPressed: () {
                            String localConnectStatus = _connectionStatus;
                            localConnectStatus = localConnectStatus.substring(
                                1, localConnectStatus.length - 1);
                            if (localConnectStatus !=
                                widget.locksDetails.lockSSID) {
                              showToast(context,
                                  "You should be connected to ${widget.locksDetails.lockSSID} to refresh the lock settings");
                              return;
                            }

                            showDialog(
                                context: context,
                                builder: (cont) {
                                  final formKey = GlobalKey<FormState>();
                                  TextEditingController _pinController =
                                      TextEditingController();

                                  return Form(
                                    key: formKey,
                                    child: AlertDialog(
                                      title: const Text('BBT Lock'),
                                      content: const Text(
                                          'Enter the lock pin to proceed'),
                                      actions: [
                                        Column(
                                          children: [
                                            TextFormField(
                                              maxLength: 4,
                                              controller: _pinController,
                                              validator: (value) {
                                                if (value!.length <= 3) {
                                                  return "Lock Pin cannot be less than 4 letters";
                                                }
                                                if (_pinController.text !=
                                                    widget.locksDetails
                                                        .privatePin) {
                                                  return "Pin does not match";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  // borderSide: BorderSide(width: 40),
                                                ),
                                                labelText: "Enter Old Pin",
                                                labelStyle: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('CANCEL'),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      if (_pinController.text ==
                                                          widget.locksDetails
                                                              .privatePin) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    UpdateLockInstallationPage(
                                                                        lockDetails:
                                                                            widget.locksDetails)));
                                                      } else {
                                                        Navigator.pop(context);
                                                        showToast(context,
                                                            "Pin do not match");
                                                      }
                                                    }
                                                  },
                                                  child: const Text('Confirm'),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(Icons.refresh_rounded)),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          tooltip: "Show Details",
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          },
                          icon: hide
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(CupertinoIcons.eye_slash_fill)),
                      const SizedBox(
                        width: 10,
                      ),
                      Transform.scale(
                          scale: 1,
                          child: Switch(
                            onChanged: (value) async {
                              String localConnectStatus = _connectionStatus;
                              localConnectStatus = localConnectStatus.substring(
                                  1, localConnectStatus.length - 1);
                              if (localConnectStatus !=
                                  widget.locksDetails.lockSSID) {
                                showToast(context,
                                    "You should be connected to ${widget.locksDetails.lockSSID} to refresh the lock settings");
                                setState(() {
                                  widget.locksDetails.isAutoLock = !value;
                                });
                                return;
                              }
                              if (value) {
                                await ApiConnect.hitApiPost(
                                    "${widget.locksDetails.iPAddress}/Autolock",
                                    {"AutoLockTime": "ON"});
                              } else {
                                await ApiConnect.hitApiPost(
                                    "${widget.locksDetails.iPAddress}/Autolock",
                                    {"AutoLockTime": "OFF"});
                              }

                              await _storageController.updateLockAutoStatus(
                                  widget.locksDetails.lockSSID, value);
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      MyNavigationBar(),
                                ),
                                (route) =>
                                    false, //if you want to disable back feature set to false
                              );
                            },
                            value: widget.locksDetails.isAutoLock,
                            activeColor: appBarColour,
                            activeTrackColor: backGroundColour,
                            inactiveThumbColor: blackColour,
                            inactiveTrackColor: whiteColour,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
