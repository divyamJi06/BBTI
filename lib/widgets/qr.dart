import 'dart:ui';

import 'package:bbti/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class QRPage extends StatelessWidget {
  final String data;
  const QRPage({required this.data, super.key});
  Future _shareQRImage() async {
    final image = await QrPainter(
      data: data,
      version: QrVersions.auto,
      gapless: true,
      color: Colors.black,
      emptyColor: Colors.white,
    ).toImageData(200.0, format: ImageByteFormat.png);

    final filename = 'qr_code.png';
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$filename').create();
    var bytes = image!.buffer.asUint8List();
    await file.writeAsBytes(bytes);
    final path = await Share.shareXFiles(
      [XFile(file.path)],
      text: 'QR code for ${data}',
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
        child: CustomAppBar(heading: "QR CODE "),
        preferredSize: Size.fromHeight(60),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QrImageView(
              data: data,
              version: QrVersions.auto,
              size: 200.0,
            ),
            ElevatedButton(onPressed: _shareQRImage, child: Text("Share"))
          ],
        ),
      ),
    );
  }
}