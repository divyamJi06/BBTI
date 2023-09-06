import 'dart:ui';

import 'custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/permission.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

class QRPage extends StatefulWidget {
  final String data;
  QRPage({required this.data, super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  GlobalKey globalKey = GlobalKey();
  final ConnectivityResult _connectionStatusS = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    print(widget.data);
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

  Future<void> converQrCodeToImage(BuildContext context, String data) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3);
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File("$directory/qrCode.png");
    await imgFile.writeAsBytes(pngBytes);
    await Share.shareFiles([imgFile.path]);
  }

  // Future _shareQRImage() async {
  //   var data = widget.data;
  //   final image = await QrPainter(
  //     data: data,
  //     version: QrVersions.auto,
  //     gapless: false,
  //     // color: Colors.black,
  //     emptyColor: Colors.white,
  //   ).toImageData(200.0); // Generate QR code image data

  //   final filename = 'qr_code.png';
  //   final tempDir =
  //       await getTemporaryDirectory(); // Get temporary directory to store the generated image
  //   final file = await File('${tempDir.path}/$filename')
  //       .create(); // Create a file to store the generated image
  //   var bytes = image!.buffer.asUint8List(); // Get the image bytes
  //   await file.writeAsBytes(bytes); // Write the image bytes to the file
  //   final path = await Share.shareFiles([file.path],
  //       text: 'QR code for ${data}',
  //       subject: 'QR Code',
  //       mimeTypes: [
  //         'image/png'
  //       ]); // Share the generated image using the share_plus package
  //   //print('QR code shared to: $path');
  // }
  Future _shareQRImage() async {
    final image = await QrPainter(
      data: widget.data,
      version: QrVersions.auto,
      gapless: false,
      color: Colors.white,
      // emptyColor: Colors.white,
    ).toImageData(200.0, format: ImageByteFormat.png);
    const filename = 'qr_code.png';
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$filename').create();
    var bytes = image!.buffer.asUint8List();
    await file.writeAsBytes(bytes);
    final path = await Share.shareXFiles(
      [XFile(file.path)],
      // text: 'QR code for $data',
      subject: 'QR Code',
      // mimeTypes: [
      //   'image/png'
      // ]
    ); // Share the generated image using the share_plus package
    //print('QR code shared to: $path');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(heading: "QR CODE "),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RepaintBoundary(
                key: globalKey,
                child: QrImageView(
                  data: widget.data,
                  backgroundColor: whiteColour,
                  version: QrVersions.auto,
                  gapless: true,
                  foregroundColor: blackColour,
                  size: 200.0,
                ),
              ),
              // Text(data),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    // _shareQRImage();
                     converQrCodeToImage(context, widget.data);
                  },
                  child: Text("Share")),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  'WIFI is connected to Wifi Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: "Open WIFI Settings",
                  onPressed: () {
                    OpenSettings.openWIFISetting();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
