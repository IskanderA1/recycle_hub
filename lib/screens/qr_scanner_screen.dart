import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/style/theme.dart';

class QRCodeContainer extends StatelessWidget {
  const QRCodeContainer({Key key, this.userState}) : super(key: key);

  final AuthStateLogedIn userState;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 80,
        padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
      color: kColorWhite,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Column(
    children: [
      Container(
        child: InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.expand_more_sharp,
              color: kColorGreyDark,
              size: 50,
            ),
          ),
        ),
        color: Colors.transparent,
      ),
      Container(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Text(
              "Покажите этот qr код сотруднику пункта приёма и зарабатывайте баллы",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        color: kColorWhite,
        height: 310,
        child: Center(
          child: QrImage(
            data: userState.user.token,
            version: QrVersions.auto,
            dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: kColorGreyLight),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        child: Text(
          "Мой QR-код",
          style: TextStyle(
              color: kColorBlack,
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
      )
    ],
        ),
      );
  }
}

/* class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller.pauseCamera();
  //   }
  //   controller.resumeCamera();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 80,
      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36), topRight: Radius.circular(36))),
      child: Column(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.expand_more_sharp,
                  color: kColorGreyDark,
                  size: 50,
                ),
              ),
            ),
            color: Colors.transparent,
          ),
          Container(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                Text(
                  "Покажите этот qr код сотруднику пункта приёма и зарабатывайте баллы",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            color: kColorWhite,
            height: 310,
            child: Center(
              child: QrImage(
                data: "sdfsdfsdfsdf sdf sd fsd f",
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              "Мой QR-код",
              style: TextStyle(
                  color: kColorBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          )
        ],
      ),
    );
    //   return Scaffold(
    //     body: StreamBuilder(
    //         stream: qrBloc.subject.stream,
    //         builder: (context, AsyncSnapshot<QRStates> snapshot) {
    //           Icon icon;
    //           if (snapshot.hasData) {
    //             switch (snapshot.data.runtimeType) {
    //               case QRInitialState:
    //                 icon = Icon(
    //                   Icons.flash_on_rounded,
    //                   size: 40,
    //                 );
    //                 break;
    //               case QROnFlasChangeState:
    //                 QROnFlasChangeState changeState = snapshot.data;
    //                 changeState.data
    //                     ? icon = Icon(
    //                         Icons.flash_off_rounded,
    //                         size: 40,
    //                       )
    //                     : icon = Icon(
    //                         Icons.flash_on_rounded,
    //                         size: 40,
    //                       );
    //             }
    //             return Stack(
    //               children: <Widget>[
    //                 Container(child: _buildQrView(context)),
    //                 Padding(
    //                   padding: const EdgeInsets.only(bottom: 50),
    //                   child: Align(
    //                     alignment: Alignment.bottomCenter,
    //                     child: FittedBox(
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                         children: <Widget>[
    //                           Text(
    //                             'Наведите камеру на QR код',
    //                             style:
    //                                 TextStyle(color: kColorWhite, fontSize: 18),
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           Container(
    //                               padding: EdgeInsets.all(10),
    //                               decoration: BoxDecoration(
    //                                   color: kColorGreen,
    //                                   shape: BoxShape.circle),
    //                               child: InkWell(
    //                                   onTap: () async {
    //                                     await controller?.toggleFlash();
    //                                     qrBloc.mapEventToState(
    //                                         QROnFlasChangeEvent(
    //                                             data: await controller
    //                                                 ?.getFlashStatus()));
    //                                   },
    //                                   child: icon)),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             );
    //           } else {
    //             return Container();
    //           }
    //         }),
    //   );
    // }

    // Widget _buildQrView(BuildContext context) {
    //   // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    //   double scanArea = MediaQuery.of(context).size.width - 120;
    //   // To ensure the Scanner view is properly sizes after rotation
    //   // we need to listen for Flutter SizeChanged notification and update controller
    //   return QRView(
    //     key: qrKey,
    //     onQRViewCreated: _onQRViewCreated,
    //     overlay: QrScannerOverlayShape(
    //         borderColor: kColorGreen,
    //         borderRadius: 0,
    //         borderLength: 20,
    //         borderWidth: 5,
    //         cutOutSize: scanArea),
    //   );
    // }

    // void _onQRViewCreated(QRViewController controller) {
    //   setState(() {
    //     this.controller = controller;
    //   });
    //   controller.scannedDataStream.listen((scanData) {
    //     if (scanData != null) {
    //       controller.dispose();
    //       qrBloc.mapEventToState(QROnCloseEvent());
    //     }
    //   });
    // }
  }
} */
