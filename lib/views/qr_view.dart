// import 'package:bbti/models/lock_initial.dart';
// import 'package:bbti/views/qr_details.dart';
// import 'package:flutter/material.dart';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'dart:convert';

// class QRViewExample extends StatefulWidget {
//   const QRViewExample({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }

// class _QRViewExampleState extends State<QRViewExample> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     var a = {
//       "Lockld": "BBT10100",
//       "LockSSID": "E-LOCK",
//       "LockPassword": 123456789,
//       "IPAddress": "http://192.168.6.6"
//     };
//     details = LockDetails(
//         lockld: "BBT10100",
//         lockSSID: "E-LOCK",
//         lockPassword: "123456789",
//         iPAddress: "http://192.168.6.6");
//   }

//   Barcode? result;
//   QRViewController? controller;
//   LockDetails details = LockDetails(
//       lockld: "BBT10100",
//       lockSSID: "E-LOCK",
//       lockPassword: "123456789",
//       iPAddress: "http://192.168.6.6");
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//           Expanded(
//             flex: 1,
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   if (result != null)
//                     Text(
//                         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                   else
//                     const Text('Scan a code'),
// Container(
//   margin: const EdgeInsets.all(8),
//   child: ElevatedButton(
//       onPressed: () async {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => BarCodeDetailsWidget(
//                       details: details,
//                     )));
//         dispose();
//       },
//       child: Text("Submit")),
// ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await controller?.pauseCamera();
//                           },
//                           child: const Text('pause',
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await controller?.resumeCamera();
//                           },
//                           child: const Text('resume',
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//         if (result != null) {
//           print(result!.code!);
//           var jsonn = json.decode(result!.code!);
//           print(jsonn);
//           details = LockDetails.fromJson(jsonn);
//           if (Platform.isAndroid) {
//             controller.pauseCamera();
//           }
//           print(details.iPAddress);
//           controller.dispose();
//         }
//       });
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

import 'dart:convert';

import 'package:bbti/constants.dart';
import 'package:bbti/models/lock_initial.dart';
import 'package:bbti/views/newlockinstallation.dart';
import 'package:bbti/views/qr_details.dart';
import 'package:bbti/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../widgets/custom_appbar.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({super.key});

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scanQR();
  }

  String _scanBarcode = 'Unknown';
  LockDetails details = LockDetails(
      lockld: "Unknown",
      lockSSID: "Unknown",
      lockPassword: "Unknown",
      isAutoLock: false,
      privatePin: "1234",
      iPAddress: "Unknown");
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      var jsonR = json.decode(barcodeScanRes);
      details = LockDetails(
          lockld: jsonR['LockId'],
          isAutoLock: false,
          privatePin: "1234",
          lockSSID: jsonR['LockSSID'],
          lockPassword: jsonR['LockPassword'].toString(),
          iPAddress: jsonR['IPAddress']);
      // details = LockDetails(lockld: barcodeScanRes[''], lockSSID: lockSSID, lockPassword: lockPassword, iPAddress: iPAddress)
    });
  }

  @override
  Widget build(BuildContext context) {
    if (details.lockld == "Unknown")
      return const Center(child: CircularProgressIndicator());
    return GestureDetector(
      // onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: CustomAppBar(heading: "QR Details")),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 180,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(5, 5), // changes position of shadow
                          ),
                        ],
                        color: whiteColour,
                        borderRadius: BorderRadius.circular(12)),
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
                              Wrap(
                                children: [
                                  Text(
                                    details.lockld,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: blackColour,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
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
                              Wrap(
                                children: [
                                  Text(
                                    details.lockSSID,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: blackColour,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Lock Password : ",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: blackColour,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                details.lockPassword,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: blackColour,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),

                          const Text(
                            "Please NOTE down the password you will need to configure and chnage the lock",
                            style: TextStyle(fontSize: 18),
                          ),
                          // Text("Start and End Date : 00-00"),
                          // Text("Start and End Time : 00:00-00:00"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  width: 200,
                  text: "Next",
                  onPressed: () {
                    // print('Button pressed ...');
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Instructions'),
                        content: const Text(
                            'Below to personalize your configuration you are required to change the lock name and password for security purpose.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewInstallationPage(
                                            lockDetails: details,
                                          )));
                            },
                            // Navigator.pop(context, 'Contii'),
                            child: const Text('Continue'),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(title: const Text('Barcode scan')),
  //       body: Builder(builder: (BuildContext context) {
  //         return Container(
  //             alignment: Alignment.center,
  //             child: Flex(
  //                 direction: Axis.vertical,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   // ElevatedButton(
  //                   //     onPressed: () => scanBarcodeNormal(),
  //                   //     child: Text('Start barcode scan')),
  //                   // ElevatedButton(
  //                   //     onPressed: () => scanQR(),
  //                   //     child: Text('Start QR scan')),
  //                   // ElevatedButton(
  //                   //     onPressed: () => startBarcodeScanStream(),
  //                   //     child: Text('Start barcode scan stream')),
  //                   Text('Scan result : $_scanBarcode\n',
  //                       style: TextStyle(fontSize: 20)),

  //                   Container(
  //                     margin: const EdgeInsets.all(8),
  //                     child: ElevatedButton(
  //                         onPressed: () async {
  //                           Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) => BarCodeDetailsWidget(
  //                                         details: details,
  //                                       )));
  //                           dispose();
  //                         },
  //                         child: Text("Submit")),
  //                   ),
  //                 ]));
  //       }));
  // }
}
