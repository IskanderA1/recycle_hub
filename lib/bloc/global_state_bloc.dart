import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/helpers/settings.dart';
import 'package:rxdart/rxdart.dart';

enum GLobalStates { FIRSTIN, AUTH, TABS }

class GlobalStateBloc {
  UserService _service = UserService();
  final BehaviorSubject<GLobalStates> _subject =
      BehaviorSubject<GLobalStates>();

  getComeIn() async {
    bool _comeIn = await Settings().getIsFirstLaunch();
    if (_comeIn == true) {
      _subject.sink.add(GLobalStates.FIRSTIN);
    } else {
      pickItem(GLobalStates.TABS);
    }
  }

  pickItem(GLobalStates i) {
    _subject.sink.add(i);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GLobalStates> get subject => _subject;
}

final globalStateBloc = GlobalStateBloc();
