import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/screens/tabs/eco_coin/eco_coin_screen.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/eco_gide_screen.dart';
import 'package:recycle_hub/screens/tabs/map/map_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_screen.dart';

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
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: bottomNavBarBloc.itemStream,
          initialData: bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.MAP:
                return MapScreen();
              case NavBarItem.ECO_GIDE:
                return EcoGideScreen();
              case NavBarItem.ECO_COIN:
                return EcoCoinScreen();
              case NavBarItem.PROFILE:
                return ProfileScreen();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){ },
        child: Icon(Icons.qr_code),
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    
      bottomNavigationBar: StreamBuilder(
        stream: bottomNavBarBloc.itemStream,
        initialData: bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return Container(
            child: ClipRRect(
              child: BottomNavigationBar(
           
                type: BottomNavigationBarType.fixed,
               
                currentIndex: snapshot.data.index,
                onTap: (int i) {
                  bottomNavBarBloc.pickItem(i);
                },
                items: [
                  BottomNavigationBarItem(
                    label: "Карта",
                    icon: Icon(Icons.map_outlined),
                    activeIcon: Icon(Icons.map),
                  ),
                  BottomNavigationBarItem(
                    label: "ЭкоГид",
                    icon: Icon(Icons.school_outlined),
                    activeIcon: Icon(Icons.school),
                  ),
                  BottomNavigationBarItem(
                    label: "ЭкоКоин",
                    icon: Icon(Icons.copyright_outlined),
                    activeIcon: Icon(Icons.copyright),
                  ),
                  BottomNavigationBarItem(
                    label: "Профиль",
                    icon: Icon(Icons.person_outlined),
                    activeIcon: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
