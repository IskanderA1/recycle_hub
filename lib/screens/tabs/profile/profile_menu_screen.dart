import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';
import 'point_profile_screen.dart';

class ProfileMenuScreen extends StatefulWidget {
  @override
  _ProfileMenuScreenState createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: profileMenuBloc.subject.stream,
        initialData: profileMenuBloc.defaultState,
        builder: (context, AsyncSnapshot<ProfileMenuStates> snapshot) {
          switch (snapshot.data) {
            case ProfileMenuStates.USER_PROFILE:
              return ProfileScreen();
              break;
            case ProfileMenuStates.POINT_PROFILE:
              return PointProfileScreen();
              break;
          }
        });
  }
}
