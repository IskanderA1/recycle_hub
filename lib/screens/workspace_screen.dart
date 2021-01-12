import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/main_eco_screen.dart';
import 'package:recycle_hub/screens/tabs/map/map_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';
import 'package:recycle_hub/widgets/fab_buttom.dart';

class WorkSpaceScreen extends StatefulWidget {
  @override
  _WorkSpaceState createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpaceScreen> {
  final loginController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: bottomNavBarBloc.itemStream,
        initialData: bottomNavBarBloc.defaultItem,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
          Widget child;
          switch (snapshot.data) {
            case NavBarItem.MAP:
              child = MapScreen();
              break;
            case NavBarItem.ECO_GIDE:
              child = EcoMainScreen();
              break;
            case NavBarItem.ECO_COIN:
              child = EcoCoinScreen();
              break;
            case NavBarItem.PROFILE:
              child = ProfileScreen();
              break;
          }
          return Scaffold(
              body: BottomNavBarV2(
                  selectedIconThemeData: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedIconTheme,
                  unselectedIconThemeData: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedIconTheme,
                  backgraundColor: Theme.of(context).backgroundColor,
                  currentItem: snapshot.data.index,
                  child: child));
        },
      ),
    );
  }
}
