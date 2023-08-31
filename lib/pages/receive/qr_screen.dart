import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../core/util/constants.dart';


class QrScannerView extends StatefulWidget {
  static String id = '/qr_screen';
  const QrScannerView({Key? key}) : super(key: key);

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      controller.pauseCamera().then((value) {
        if (result != null && result!.code != null) {
          Map<String, dynamic> data = jsonDecode(result!.code!);

          /*List<UserClass> sameNameUsers = await*/
        }}     );
  });}

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Scan Qr Code',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              // onQRViewCreated: /*_onQRViewCreated*/
              overlay: QrScannerOverlayShape(
                borderWidth: 10,
                borderColor: kPrimaryColor,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ), onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }
}