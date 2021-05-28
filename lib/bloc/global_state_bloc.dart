import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:recycle_hub/api/app_repo.dart';

enum GLobalStates { FIRSTIN, AUTH, TABS }

class GlobalStateBloc {
  final AppService _repository = AppService();
  final BehaviorSubject<GLobalStates> _subject =
      BehaviorSubject<GLobalStates>();

  getComeIn() async {
    bool _comeIn = await _repository.getComeInNum();
    if (_comeIn == true) {
      _subject.sink.add(GLobalStates.FIRSTIN);
    } else {
      int i = await authBloc.authLocal();
      if (i == 0)
        pickItem(GLobalStates.TABS);
      else
        pickItem(GLobalStates.AUTH);
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
