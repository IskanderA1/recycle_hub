import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:recycle_hub/repo/app_repo.dart';

enum GLobalStates { FIRSTIN, AUTH, TABS }

class GlobalStateBloc {
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<GLobalStates> _subject =
      BehaviorSubject<GLobalStates>();

  getComeIn() async {
    bool _comeIn = await _repository.getComeInNum();
    if (_comeIn == true) {
      _subject.sink.add(GLobalStates.FIRSTIN);
    } else {
      UserResponse response = await _repository.userAuthLocal();
      if (response is UserLoggedIn) {
        _subject.sink.add(GLobalStates.TABS);
      } else {
        _subject.sink.add(GLobalStates.AUTH);
      }
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
