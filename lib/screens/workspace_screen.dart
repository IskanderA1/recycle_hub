import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/main_eco_screen.dart';
import 'package:recycle_hub/screens/tabs/map/map_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:recycle_hub/widgets/fab_buttom.dart';

class WorkSpaceScreen extends StatefulWidget {
  @override
  _WorkSpaceState createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpaceScreen> {
  final loginController = TextEditingController();
  final passController = TextEditingController();

  final MapScreen _screen = MapScreen();

  @override
  void initState() {
    super.initState();
    markersCollectionBloc.loadMarkers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;

  void pickIndex(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: customDrawer,
      body: Stack(children: [
        IndexedStack(index: bottomNavBarBloc.index, children: [
          MapScreen(),
          EcoMainScreen(),
          EcoCoinScreen(),
          ProfileScreen()
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            child: StreamBuilder(
                stream: bottomNavBarBloc.itemStream,
                initialData: bottomNavBarBloc.defaultItem,
                // ignore: missing_return
                builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
                  return BottomNavBarV2(
                    func: pickIndex,
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
        )
      ]),
    );
  }
}
