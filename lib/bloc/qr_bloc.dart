import 'package:flutter/material.dart';
import 'package:recycle_hub/screens/qr_scanner_screen.dart';
import 'package:rxdart/rxdart.dart';

//events
abstract class QREvents {}

class QRInitialEvent extends QREvents {
  final BuildContext context;
  QRInitialEvent({this.context});
}

class QROnFlasChangeEvent extends QREvents {
  final bool data;
  QROnFlasChangeEvent({this.data});
}

class QROnCloseEvent extends QREvents {}

//states
abstract class QRStates {}

class QROnFlasChangeState extends QRStates {
  final bool data;
  QROnFlasChangeState({this.data});
}

class QRInitialState extends QRStates {}

class QRBloc {
  BehaviorSubject<QRStates> _subject = BehaviorSubject<QRStates>();
  BehaviorSubject<QRStates> get subject => _subject;
  BuildContext _context;
  void mapEventToState(QREvents event) {
    switch (event.runtimeType) {
      case QRInitialEvent:
        QRInitialEvent initialEvent = event;
        _context = initialEvent.context;
        Navigator.of(initialEvent.context)
            .push(MaterialPageRoute(builder: (context) => QRScannerScreen()));
        _subject.sink.add(QRInitialState());
        break;
      case QROnCloseEvent:
        Navigator.of(_context).pop();
        break;
      case QROnFlasChangeEvent:
        QROnFlasChangeEvent changeEvent = event;
        _subject.sink.add(QROnFlasChangeState(data: changeEvent.data));
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final qrBloc = QRBloc();
