import 'dart:convert';

import '../constants.dart';
import '../models/lock_initial.dart';
import 'newlockinstallation.dart';
import '../widgets/custom_button.dart';
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
