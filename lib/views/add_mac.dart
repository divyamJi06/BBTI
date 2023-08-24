import 'dart:async';

import '../bottom_nav_bar.dart';
import '../controllers/storage.dart';
import '../models/mac_model.dart';
import '../widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';
import '../controllers/apis.dart';
import '../controllers/permission.dart';
import '../models/lock_initial.dart';
import '../widgets/custom_appbar.dart';

class NewMacInstallationPage extends StatefulWidget {
  NewMacInstallationPage({required this.lockDetails, super.key});
  final LockDetails lockDetails;

  @override
  State<NewMacInstallationPage> createState() => _NewMacInstallationPageState();
}

class _NewMacInstallationPageState extends State<NewMacInstallationPage> {
  final TextEditingController _macID = TextEditingController();

  final TextEditingController _macName = TextEditingController();

  final StorageController _storageController = StorageController();

  final formKey = GlobalKey<FormState>();




  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  // late LockDetails? _lockDetails;

  @override
  void initState() {
    super.initState();
    _initNetworkInfo();
    // getLockId();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // String? lockID;
  // getLockId() async {
  //   List<LockDetails> locks = await _storage.readLocks();
  //   for (var element in locks) {
  //     if (_connectionStatus.contains(element.lockSSID)) {
  //       setState(() {
  //         _lockDetails = element;
  //         lockID = element.lockld;
  //         _lockId.text = element.lockld;
  //       });
  //       break;
  //     }
  //   }
  // }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _initNetworkInfo();
  }

  final NetworkInfo _networkInfo = NetworkInfo();
  Future<void> _initNetworkInfo() async {
    String? wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask;

    try {
      await requestPermission(Permission.nearbyWifiDevices);
      // await requestPermission(Permission.locationWhenInUse);
    } catch (e) {}

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
        } else {
        }
      } else {
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
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
        } else {
        }
      } else {
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
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
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(heading: "Add Mac")),
        body: Center(
          child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _macID,
                          maxLength: 12,
                          validator: (value) {
                            if (value!.isEmpty) return "Mac ID cannot be empty";
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Mac ID",
                            labelStyle: const TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: _macName,
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Mac Name cannot be empty";
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Mac Name",
                              labelStyle: const TextStyle(fontSize: 15),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          width: 200,
                          text: "Submit",
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await ApiConnect.hitApiGet(
                                routerIP + "/",
                              );

                              var res = await ApiConnect.hitApiPost(
                                  "$routerIP/macid", {
                                "MacID": _macID.text.toLowerCase(),
                              });

                              MacsDetails macsDetails = MacsDetails(
                                  lockDetails: widget.lockDetails,
                                  id: _macID.text,
                                  name: _macName.text,
                                  isPresentInESP: true);
                              _storageController.addmacs(macsDetails);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyNavigationBar()));
                            }
                          },
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await ApiConnect.hitApiGet(
                                  routerIP + "/",
                                );

                                var res = await ApiConnect.hitApiPost(
                                    "$routerIP/deletemac", {
                                  "MacID": _macID.text.toLowerCase(),
                                });

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => PassKeyPage()));
                              }
                            },
                            child: const Text("Delete")),
                      ],
                    ),
                  ),
                ),
        ));
  }
}




    //  JSONObject json = new JSONObject();
    //                 try {
    //                     json.put("MacCheck", "OFF");
    //                 } catch (JSONException e) {
    //                     Log.d(TAG, e.getMessage());
    //                 }
    //                 StringEntity entity = new StringEntity(json.toString(), "UTF-8");
    //                 System.out.println(entity);
    //                 client.post(getApplicationContext(), lockip + "/MacOnOff", entity, "application/json", new JsonHttpResponseHandler() {
