import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/screens/tabs/eco_gide/main_eco_screen.dart';
import 'package:recycle_hub/screens/tabs/map/map_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/profile_menu_screen.dart';
import 'package:recycle_hub/widgets/fab_buttom.dart';

import 'tabs/eco_coin/eco_coin_menu.dart';

class WorkSpaceScreen extends StatefulWidget {
  @override
  _WorkSpaceState createState() => _WorkSpaceState();
}

class _WorkSpaceState extends State<WorkSpaceScreen> {
  StreamSubscription streamSubscription;
  int _currentInd;
  @override
  void initState() {
    _currentInd = 0;
    streamSubscription = bottomNavBarBloc.itemStream.listen((event) {
      setState(() {
        if(event == NavBarItem.MAP){
          _currentInd = 0;
      }else if(event == NavBarItem.ECO_GIDE){
        _currentInd = 1;
      }else if(event == NavBarItem.ECO_COIN){
        _currentInd = 2;
      }else {
        _currentInd=3;
      }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeCurrent(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(),
      body: Stack(children: [
        IndexedStack(index: _currentInd, children: [
          MapScreen(),
          EcoMainScreen(),
          EcoCoinMainScreen(),
          ProfileMenuScreen(),
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            child: BottomNavBarV2(
              func: (){},
              selectedIconThemeData:
                  Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
              unselectedIconThemeData: Theme.of(context)
                  .bottomNavigationBarTheme
                  .unselectedIconTheme,
              backgraundColor: Theme.of(context).backgroundColor,
              currentItem: bottomNavBarBloc.index,
            ),
          ),
        )
      ]),
    );
  }
}
