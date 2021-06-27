/* import 'dart:async';

import 'package:rxdart/rxdart.dart';



class EcoCoinMenuBloc{
  EcoCoinMenuBloc(){
    
  }
  StreamController<EcoCoinMenuItems> _subject = StreamController<EcoCoinMenuItems>.broadcast();

  Stream<EcoCoinMenuItems> get stream => _subject.stream;
  EcoCoinMenuItems get defaultItem => EcoCoinMenuItems.MENU;

  pickState(EcoCoinMenuItems item){
    _subject.sink.add(item);
    /*switch (item){
      case EcoCoinMenuItems.STORE:
        
        break;
      case EcoCoinMenuItems.GIVEGARBAGE:
      case EcoCoinMenuItems.OFFERNEWPOINT:
      case EcoCoinMenuItems.ANSWERQUESTS:
      case EcoCoinMenuItems.RECOMMEND:
      case EcoCoinMenuItems.FEEDBACK:
    }*/
  }
  dispose(){
    _subject.close();
  }
}

EcoCoinMenuBloc ecoCoinMenuBloc = EcoCoinMenuBloc();
 */