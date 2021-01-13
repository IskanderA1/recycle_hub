import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/repo/eco_quide_repo.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_guide_tabs/main_eco_guide_screen.dart';
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
      body: Stack(children: [
        StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
            Widget child;
            switch (snapshot.data) {
              case NavBarItem.MAP:
                return MapScreen();
                break;
              case NavBarItem.ECO_GIDE:
                return EcoMainScreen();
                break;
              case NavBarItem.ECO_COIN:
                return EcoCoinScreen();
                break;
              case NavBarItem.PROFILE:
                return ProfileScreen();
                break;
            }
          },
        ),
        //WorkSpaceScreen(),
        _bottomNavBarAlignment(),
      ]),
    );
  }
}

Align _bottomNavBarAlignment() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: 70,
      child: StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
            return BottomNavBarV2(
              selectedIconThemeData:
                  Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
              unselectedIconThemeData: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedIconTheme,
              backgraundColor: Theme.of(context).backgroundColor,
              currentItem: snapshot.data.index,
            );
          }),
    ),
  );
}
/*Scaffold(
      appBar: mapScreenAppBar(context),
      /*PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.MAP:
                return mapScreenAppBar(context);
                break;
              case NavBarItem.ECO_GIDE:
                return ecoGuideScreenAppBer();
                break;
              case NavBarItem.ECO_COIN:
                return ecoCoinScreenAppBar();
                break;
              case NavBarItem.PROFILE:
                return profileScreenAppBar();
                break;
            }
          },
        ),
      ),*/
      drawer: customDrawer,
      body: googleMap(context),
      /*Stack(children: [
        StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
            Widget child;
            switch (snapshot.data) {
              case NavBarItem.MAP:
                return googleMap(context);
                break;
              case NavBarItem.ECO_GIDE:
                return EcoMainScreen();
                break;
              case NavBarItem.ECO_COIN:
                return EcoCoinScreen();
                break;
              case NavBarItem.PROFILE:
                return ProfileScreen();
                break;
            }
          },
        )*/
      /*Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            width: size.width,
            child: StreamBuilder(
                stream: bottomNavBarBloc.itemStream,
                initialData: bottomNavBarBloc.defaultItem,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
                  return BottomNavBarV2(
                    selectedIconThemeData: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedIconTheme,
                    unselectedIconThemeData: Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedIconTheme,
                    backgraundColor: Theme.of(context).backgroundColor,
                    currentItem: snapshot.data.index,
                  );
                }),
          ),
        ),
      ]),*/
    );
  }
}*/
