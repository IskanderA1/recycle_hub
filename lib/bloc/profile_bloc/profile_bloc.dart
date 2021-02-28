import 'package:rxdart/rxdart.dart';

enum ProfileMenuEvents { USER_PROFILE, POINT_PROFILE }
enum ProfileMenuStates { USER_PROFILE, POINT_PROFILE }

class ProfileMenuBloc {
  BehaviorSubject<ProfileMenuStates> _subject =
      BehaviorSubject<ProfileMenuStates>();
  BehaviorSubject<ProfileMenuStates> get subject => _subject;

  final defaultState = ProfileMenuStates.USER_PROFILE;

  void mapEventToState(ProfileMenuEvents event) {
    switch (event) {
      case ProfileMenuEvents.USER_PROFILE:
        _subject.sink.add(ProfileMenuStates.USER_PROFILE);
        break;
      case ProfileMenuEvents.POINT_PROFILE:
        _subject.sink.add(ProfileMenuStates.POINT_PROFILE);
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final profileMenuBloc = ProfileMenuBloc();
