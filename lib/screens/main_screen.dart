import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/model/user_response.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/main_eco_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';
import 'package:recycle_hub/screens/workspace_screen.dart';
import 'package:recycle_hub/widgets/fab_buttom.dart';
import 'package:recycle_hub/screens/tabs/map/map_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final loginController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    authBloc.authLocal();
    markersCollectionBloc.loadMarkers();
    super.initState();
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
          stream: authBloc.subject,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<UserResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                if (snapshot.data.error == "Loading") {
                  return buildLoadingWidget();
                }
                if (snapshot.data.error == "Авторизуйтесь") {
                  //TODO: Заменить на AuthScreen после того как сделаем
                  return WorkSpaceScreen();
                }
                //TODO: Заменить на AuthScreen после того как сделаем
                return WorkSpaceScreen();
              }

              return Center(
                child: WorkSpaceScreen(),
              );
            } else if (snapshot.hasError) {
              //TODO: Заменить на AuthScreen после того как сделаем
              return WorkSpaceScreen();
            } else {
              return buildLoadingWidget();
            }
          }),
    );
  }
}
