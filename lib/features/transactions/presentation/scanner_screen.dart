import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/elements/common_button.dart';
import 'package:recycle_hub/elements/common_text_button.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_admin_panel_state.dart/transactions_admin_panel_state.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/style/theme.dart';

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
      controller.resumeCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => GetIt.I.get<NavBarCubit>().goBack()),
        title: Text(
          "QR Сканнер",
          /* style: TextStyle(
            color: kColorWhite,
            fontSize: 18,
            fontFamily: 'GillroyMedium',
            fontWeight: FontWeight.bold,
          ), */
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(borderColor: kColorGreen, borderWidth: 4, cutOutSize: 300),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Наведите камеру на QR код',
                style: TextStyle(color: kColorWhite, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonButton(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(8),
                      shape: BoxShape.circle,
                      borderRadius: null,
                      backGroundColor: kColorGreen,
                      child: Icon(
                        Icons.lightbulb_outline,
                        color: kColorWhite,
                        size: 32,
                      ),
                      ontap: () {
                        controller.toggleFlash();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: CommonButton(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(8),
                        shape: BoxShape.circle,
                        borderRadius: null,
                        backGroundColor: kColorGreen,
                        child: Icon(
                          Icons.repeat,
                          color: kColorWhite,
                          size: 32,
                        ),
                        ontap: () {
                          reassemble();
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
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
      Provider.of<AdminTransactionsState>(context, listen: false).saveUserToken(scanData.code);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
