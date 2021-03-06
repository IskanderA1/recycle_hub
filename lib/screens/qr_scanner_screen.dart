import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/bloc/qr_bloc.dart';
import '../style/theme.dart';
import 'tabs/map/widgets/loader_widget.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        qrBloc.mapEventToState(QROnCloseEvent());
        return;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "QR Сканнер",
              style: TextStyle(color: kColorWhite, fontSize: 18),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp),
              onPressed: () {
                qrBloc.mapEventToState(QROnCloseEvent());
              },
            ),
          ),
          body: Container(
            color: kColorWhite,
            child: Center(
                child: CachedNetworkImage(
              placeholder: (BuildContext context, url) => LoaderWidget(),
              errorWidget: (BuildContext context, url, error) =>
                  Icon(Icons.error),
              imageUrl: "http://eco.loliallen.com" + authBloc.user.qrCode,
            )),
          )),
    );
  }

  /*StreamBuilder(
            stream: qrBloc.subject.stream,
            builder: (context, AsyncSnapshot<QRStates> snapshot) {
              Icon icon;
              if (snapshot.hasData) {
                switch (snapshot.data.runtimeType) {
                  case QRInitialState:
                    icon = Icon(
                      Icons.flash_on_rounded,
                      size: 40,
                    );
                    break;
                  case QROnFlasChangeState:
                    QROnFlasChangeState changeState = snapshot.data;
                    changeState.data
                        ? icon = Icon(
                            Icons.flash_off_rounded,
                            size: 40,
                          )
                        : icon = Icon(
                            Icons.flash_on_rounded,
                            size: 40,
                          );
                }
                return Stack(
                  children: <Widget>[
                    Container(child: _buildQrView(context)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                'Наведите камеру на QR код',
                                style:
                                    TextStyle(color: kColorWhite, fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: kColorGreen,
                                      shape: BoxShape.circle),
                                  child: InkWell(
                                      onTap: () async {
                                        await controller?.toggleFlash();
                                        qrBloc.mapEventToState(
                                            QROnFlasChangeEvent(
                                                data: await controller
                                                    ?.getFlashStatus()));
                                      },
                                      child: icon)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container();
              }
            }),
  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    double scanArea = MediaQuery.of(context).size.width - 120;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: kColorGreen,
          borderRadius: 0,
          borderLength: 20,
          borderWidth: 5,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        controller.dispose();
        qrBloc.mapEventToState(QROnCloseEvent());
      }
    });
  }*/
}
