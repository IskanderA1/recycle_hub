import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_admin_panel_state.dart/transactions_admin_panel_state.dart';

class AdminScannerScreen extends StatefulWidget {
  const AdminScannerScreen({Key key}) : super(key: key);

  @override
  _AdminScannerScreenState createState() => _AdminScannerScreenState();
}

class _AdminScannerScreenState extends State<AdminScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  bool _scanned = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                controller.resumeCamera();
              },
              child: Center(
                child: (result != null)
                    ? Text(
                        'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                    : Text('Scan a code'),
              ),
            ),
          ),
          SizedBox(height: 150),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (_scanned) {
        return;
      }
      setState(() {
        _scanned = true;
      });
      print(scanData.code);
      Provider.of<AdminTransactionsState>(context, listen: false)
          .saveUserToken(scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
