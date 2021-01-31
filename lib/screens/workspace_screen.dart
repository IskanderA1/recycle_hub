import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/map_screen_blocs/markers_collection_bloc.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/screens/tabs/bottom_nav_bar.dart';
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
        CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: "Карта",
              ),
              BottomNavigationBarItem(
                label: "ЭкоГид",
                icon: Icon(Icons.school_outlined),
              ),
              BottomNavigationBarItem(
                icon: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: kColorGreen,
                  onPressed: () {
                    markersCollectionBloc.loadMarkers();
                  },
                  child: Container(
                    child: Icon(
                      Icons.qr_code,
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "ЭкоКоин",
                icon: Icon(Icons.copyright_outlined),
              ),
              BottomNavigationBarItem(
                label: "Профиль",
                icon: Icon(Icons.person_outlined),
              )
            ],
          ),
          tabBuilder: (BuildContext context, itemInd) {
            CupertinoTabView tabViewItem;
            switch (itemInd) {
              case 0:
                tabViewItem = CupertinoTabView(
                  builder: (BuildContext context) {
                    return MapScreen();
                  },
                );
                break;
              case 1:
                tabViewItem = CupertinoTabView(
                  builder: (BuildContext context) {
                    return EcoMainScreen();
                  },
                );
                break;
              case 2:
                tabViewItem = CupertinoTabView(
                  builder: (BuildContext context) {
                    return EcoCoinScreen();
                  },
                );
                break;
              case 3:
                tabViewItem = CupertinoTabView(
                  builder: (BuildContext context) {
                    return ProfileScreen();
                  },
                );
                break;
              default:
                tabViewItem = CupertinoTabView(
                  builder: (BuildContext context) {
                    return MapScreen();
                  },
                );
              //default:
              //return MapScreen();
              //break;

            }
            return tabViewItem;
          },
        ),
      ]),
    );
    /*Scaffold(
      drawer: customDrawer,
      body: Stack(children: [
        StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
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
        bottomNavBar,
      ]),
    );*/
  }
}
