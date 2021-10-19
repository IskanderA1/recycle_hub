import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
import 'package:recycle_hub/screens/drawers/about_app_screen.dart';
import 'package:recycle_hub/screens/drawers/contacts_screen.dart';
import 'package:recycle_hub/screens/drawers/partnters_list_screen.dart';
import 'package:recycle_hub/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recycle_hub/screens/drawers/about_project_screen.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int total = 0;
  StreamSubscription<AuthState> _streamSubscription;

  @override
  void initState() {
    /* _streamSubscription = GetIt.I.get<AuthBloc>().stream.listen((state) {
      total = state.userModel.
    }); */
    total = UserService().statistic != null ? UserService().statistic.total : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(bottom: 45),
        children: <Widget>[
          UserService().usersCount != null
              ? Container(
                  color: Colors.grey[300],
                  child: Stack(children: [
                    SvgPicture.asset(
                      "svg/drawer_header.svg",
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 30, top: 45, bottom: 20, right: 30),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            "Ура! В сервисе RecycleHub ${UserService().usersCount} пользователей",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ]),
                )
              : SizedBox.shrink(),
          _CommonDrawerCell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsScreen(),
                ),
              );
            },
            title: "Новости",
          ),
          _CommonDrawerCell(
            onTap: () {
              if (GetIt.I.get<AuthBloc>().state is AuthStateGuestAcc) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              } else if (GetIt.I.get<AuthBloc>().state is AuthStateLogedIn) {
                GetIt.I.get<NavBarCubit>().moveTo(NavBarItem.PROFILE);
                GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.STATISTIC);
                Navigator.pop(context);
              }
            },
            title: "Статистика",
          ),
          _CommonDrawerCell(
            onTap: () {
              NetworkHelper.openUrl('https://vk.com/recyclehub', context);
              Navigator.pop(context);
            },
            title: "Частые вопросы",
          ),
          _CommonDrawerCell(
            onTap: () {},
            title: "Как пользоваться",
          ),
          _CommonDrawerCell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactsScreen(),
                ),
              );
            },
            title: "Контакты",
          ),
          _CommonDrawerCell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PartnersListScreen(),
                ),
              );
            },
            title: "Партнеры",
          ),
          _CommonDrawerCell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutAppScreen(),
                ),
              );
            },
            title: "О приложении",
          ),
          _CommonDrawerCell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutProjectScreen(),
                ),
              );
            },
            title: "О проекте",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF616161), width: 0.5),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Оценить приложение',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  NetworkHelper.openUrl('https://play.google.com/store/apps/details?id=com.iskander.kai_mobile_app', context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommonDrawerCell extends StatelessWidget {
  final String title;
  final Function onTap;
  _CommonDrawerCell({this.onTap, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF616161), width: 0.5),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
