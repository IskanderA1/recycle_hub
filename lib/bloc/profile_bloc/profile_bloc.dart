import 'package:rxdart/rxdart.dart';

enum ProfileMenuStates {BACK, USER_PROFILE, POINT_PROFILE, 
STATISTIC, HOWGETCOIN, OFFERNEWPOINT, 
PURSE, STORE, EDITPROFILE,
MYPURCHASES, TOPUPSHISTORY }

class ProfileMenuBloc {
  BehaviorSubject<ProfileMenuStates> _subject =
      BehaviorSubject<ProfileMenuStates>();
  BehaviorSubject<ProfileMenuStates> get subject => _subject;

  final defaultState = ProfileMenuStates.USER_PROFILE;

  void mapEventToState(ProfileMenuStates event) {
    switch (event) {
      case ProfileMenuStates.USER_PROFILE:
        _subject.sink.add(ProfileMenuStates.USER_PROFILE);
        break;
      case ProfileMenuStates.POINT_PROFILE:
        _subject.sink.add(ProfileMenuStates.POINT_PROFILE);
        break;
      case ProfileMenuStates.STATISTIC:
        _subject.sink.add(ProfileMenuStates.STATISTIC);
        break;
      case ProfileMenuStates.HOWGETCOIN:
        _subject.sink.add(ProfileMenuStates.HOWGETCOIN);
        break;
      case ProfileMenuStates.BACK:
        _subject.sink.add(ProfileMenuStates.BACK);
        break;
      case ProfileMenuStates.OFFERNEWPOINT:
        _subject.sink.add(ProfileMenuStates.OFFERNEWPOINT);
        break;
      case ProfileMenuStates.PURSE:
        _subject.sink.add(ProfileMenuStates.PURSE);
        break;
      case ProfileMenuStates.STORE:
        _subject.sink.add(ProfileMenuStates.STORE);
        break;
      case ProfileMenuStates.EDITPROFILE:
        _subject.sink.add(ProfileMenuStates.EDITPROFILE);
        break;
      case ProfileMenuStates.MYPURCHASES:
        _subject.sink.add(ProfileMenuStates.MYPURCHASES);
        break;
      case ProfileMenuStates.TOPUPSHISTORY:
        _subject.sink.add(ProfileMenuStates.TOPUPSHISTORY);
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final profileMenuBloc = ProfileMenuBloc();
