import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_coin_menu/eco_coin_menu_cubit.dart';
import 'package:recycle_hub/bloc/eco_guide_cubit/eco_guide_cubit_cubit.dart';
import 'package:recycle_hub/bloc/map/map_bloc.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/bloc/navigation_bloc.dart';
import 'package:recycle_hub/bloc/store/store_bloc.dart';
import 'package:recycle_hub/elements/drawer.dart';
import 'package:recycle_hub/features/transactions/data/api/api_util.dart';
import 'package:recycle_hub/features/transactions/data/api/service/service.dart';
import 'package:recycle_hub/features/transactions/data/transactions_data_repository.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_admin_panel_state.dart/transactions_admin_panel_state.dart';
import 'package:recycle_hub/features/transactions/internal/transactions_module.dart';
import 'package:recycle_hub/features/transactions/presentation/admin_panel_main_screen.dart';
import 'package:recycle_hub/features/transactions/presentation/scanner_screen.dart';
import 'package:recycle_hub/helpers/filter_types.dart';
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
  StoreBloc storeBloc;

  StreamSubscription streamSubscription;
  int _currentInd;
  MapBloc mapBloc;
  List<Widget> screenWidgets;
  @override
  void initState() {
    FilterTypesService().getFilters();
    mapBloc = MapBloc()..add(MapEventInit());
    _currentInd = 0;
    storeBloc ??= StoreBloc()..add(StoreEventInit());
    screenWidgets = [
      BlocProvider.value(
        value: mapBloc,
        child: MapScreen(),
      ),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
    streamSubscription = GetIt.I.get<NavBarCubit>().stream.listen((event) {
      setState(() {
        if (event == NavBarItem.MAP) {
          _currentInd = 0;
        } else if (event == NavBarItem.ECO_GIDE) {
          _currentInd = 1;
        } else if (event == NavBarItem.ECO_COIN) {
          _currentInd = 2;
        } else if (event == NavBarItem.QRSCANNER) {
          _currentInd = 4;
        } else {
          _currentInd = 3;
        }
        if (screenWidgets[_currentInd] is Container) {
          screenWidgets[_currentInd] = getWidgetById(_currentInd);
        }
      });
    });
    super.initState();
  }

  Widget getWidgetById(int id) {
    switch (id) {
      case 0:
        return BlocProvider.value(
          value: mapBloc,
          child: MapScreen(),
        );
        break;
      case 1:
        return EcoMainScreen();
        break;
      case 2:
        return BlocProvider.value(
          value: storeBloc,
          child: EcoCoinMainScreen(),
        );
        break;
      case 3:
        return BlocProvider.value(
          value: storeBloc,
          child: ProfileMenuScreen(),
        );
        break;
      case 4:
        return Provider<AdminTransactionsState>(
            create: (_) => TransactionsModule.getAdminModule(),
            child: AdminTransactionsPanelMainScreen());
      default:
        return Container();
        break;
    }
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  void changeCurrent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var navState = GetIt.I.get<NavBarCubit>().state;
        switch (navState) {
          case NavBarItem.MAP:
            return false;
            break;
          case NavBarItem.ECO_GIDE:
            GetIt.I.get<EcoGuideCubit>().goBack();
            break;
          case NavBarItem.QRSCANNER:
            return false;
            break;
          case NavBarItem.ECO_COIN:
          GetIt.I.get<EcoCoinMenuCubit>().goBack();
            break;
          case NavBarItem.PROFILE:
          GetIt.I.get<ProfileMenuCubit>().goBack();
            break;
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: CustomDrawer(),
        body: Stack(children: [
          IndexedStack(index: _currentInd, children: screenWidgets),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              child: BottomNavBarV2(
                selectedIconThemeData: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedIconTheme,
                unselectedIconThemeData: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedIconTheme,
                backgraundColor: Theme.of(context).backgroundColor,
                currentItem: GetIt.I.get<NavBarCubit>().state.index,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
