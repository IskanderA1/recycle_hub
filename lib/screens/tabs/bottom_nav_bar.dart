import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/widgets/fab_buttom.dart';

Widget bottomNavBar = Align(
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
            unselectedIconThemeData:
                Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
            backgraundColor: Theme.of(context).backgroundColor,
            currentItem: snapshot.data.index,
          );
        }),
  ),
);
