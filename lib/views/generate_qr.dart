import 'package:flutter/material.dart';

import '../constants.dart';
import '../controllers/storage.dart';
import '../models/contacts.dart';
import '../models/lock_initial.dart';
import '../models/router_model.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/qr.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/permission.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({super.key});

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  StorageController _storageController = StorageController();
  final ConnectivityResult _connectionStatusS = ConnectivityResult.none;
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

  List<ContactsModel> contacts = [];
  List<LockDetails> locks = [];
  List<RouterDetails> routers = [];
  getData() async {
    // setState(() async {
    contacts = await _storageController.readContacts();
    locks = await _storageController.readLocks();
    routers = await _storageController.readRouters();
    // });
    return (contacts, locks, routers);
  }

  bool isSelected = true;
  String selected = "Locks";

  LockDetails lock = LockDetails(
      lockld: "default",
      lockSSID: "def",
      isAutoLock: false,
      privatePin: "1234",
      lockPassword: "default",
      iPAddress: "0.0.0.0");
  RouterDetails router = RouterDetails(
      lockID: "default",
      name: "default",
      password: "default",
      lockPasskey: "default");
  ContactsModel contact = ContactsModel(
      accessType: "default", date: "default", time: "default", name: "default");

  @override
  Widget build(BuildContext context) {
    // if (routers == null) return CircularProgressIndicator();
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(heading: "Generate QR"),
        preferredSize: const Size.fromHeight(60),
      ),
      body: Center(
          child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                print((snapshot.data.runtimeType));
                var x = snapshot.data as (
                  List<ContactsModel>,
                  List<LockDetails>,
                  List<RouterDetails>
                );
                contacts = x.$1;
                locks = x.$2;
                routers = x.$3;
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownMenu(
                        initialSelection: selected,
                        onSelected: (value) async {
                          setState(() {
                            print(value);
                            selected = value!;
                            if (value == "Locks") {
                              isSelected = true;
                            } else {
                              isSelected = false;
                            }
                          });
                        },
                        dropdownMenuEntries: [
                          const DropdownMenuEntry(
                              value: "Locks", label: "Locks"),
                          const DropdownMenuEntry(
                              value: "Routers", label: "Routers"),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    isSelected
                        ? const Text("Select Lock")
                        : const Text("Select Router"),
                    isSelected
                        ? DropdownMenu(
                            onSelected: (value) async {
                              lock =
                                  await _storageController.getLockBySSID(value);
                            },
                            dropdownMenuEntries: locks
                                .map((e) => DropdownMenuEntry(
                                    value: e.lockSSID, label: e.lockSSID))
                                .toList())
                        : DropdownMenu(
                            onSelected: (value) async {
                              router = await _storageController
                                  .getRouterByName(value);
                            },
                            dropdownMenuEntries: routers
                                .map((e) => DropdownMenuEntry(
                                    value: e.name + "_" + e.lockID,
                                    label: e.name + "_" + e.lockID))
                                .toList()),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Select Contact"),
                    DropdownMenu(
                        onSelected: (value) async {
                          contact =
                              await _storageController.getContactByPhone(value);
                        },
                        dropdownMenuEntries: contacts
                            .map((e) =>
                                DropdownMenuEntry(value: e.name, label: e.name))
                            .toList()),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QRPage(
                                        data: isSelected
                                            ? "${lock.toLockQR()},${contact.toContactsQR()}"
                                            : "${router.toRouterQR()},${contact.toContactsQR()}")));
                          },
                          child: new Text("Generate"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: new Text("Cancel"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'WIFI is connected to Wifi Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        _connectionStatus.toString(),
                        style: TextStyle(
                            color: appBarColour,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
