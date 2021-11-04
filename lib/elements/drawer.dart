import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/nav_bar_cubit/nav_bar_cubit_cubit.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/icons/menu_icons_icons.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
import 'package:recycle_hub/screens/drawers/about_app_screen.dart';
import 'package:recycle_hub/screens/drawers/contacts_screen.dart';
import 'package:recycle_hub/screens/drawers/partnters_list_screen.dart';
import 'package:recycle_hub/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recycle_hub/screens/drawers/about_project_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'dart:io' show Platform;


List<IconData> svgIcons = [
  MenuIcons.newspaper,
  MenuIcons.pie_chart,
  MenuIcons.question,
  MenuIcons.instruction,
  MenuIcons.information,
  MenuIcons.contact,
  MenuIcons.reviews,
  MenuIcons.feedback,
  
];

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int total = 0;
  StreamSubscription<AuthState> _streamSubscription;

  @override
  void initState() {
    total = UserService().statistic != null ? UserService().statistic.total : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
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
                        padding: EdgeInsets.only(
                            left: 30, top: 45, bottom: 20, right: 30),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              "Ура! В сервисе RecycleHub ${UserService().usersCount} пользователей",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
              icon: Icon(
                svgIcons[0],
                color: kColorGreyDark,
                size: 25,
              ),
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
                  GetIt.I
                      .get<ProfileMenuCubit>()
                      .moveTo(ProfileMenuStates.STATISTIC);
                  Navigator.pop(context);
                }
              },
              title: "Статистика",
              icon: Icon(
                svgIcons[1],
                color: kColorGreyDark,
                size: 25,
              ),
            ),
            _CommonDrawerCell(
              onTap: () {
                NetworkHelper.openUrl('https://vk.com/recyclehub', context);
                Navigator.pop(context);
              },
              title: "Частые вопросы",
              icon: Icon(
                svgIcons[2],
                color: kColorGreyDark,
                size: 25,
              ),
            ),
            // _CommonDrawerCell(
            //   onTap: () {},
            //   title: "Как пользоваться",
            //   icon: Icon(
            //     svgIcons[3],
            //     color: kColorGreyDark,
            //     size: 25,
            //   ),
            // ),
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
              icon: Icon(
                svgIcons[5],
                color: kColorGreyDark,
                size: 25,
              ),
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
              icon: Icon(
                svgIcons[3],
                color: kColorGreyDark,
                size: 25,
              ),
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
              icon: Icon(
                svgIcons[4],
                color: kColorGreyDark,
                size: 25,
              ),
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
              icon: Icon(
                svgIcons[6],
                color: kColorGreyDark,
                size: 25,
              ),
            ),
            _CommonDrawerCell(
              onTap: () {
                 NetworkHelper.openUrl(
                   Platform.isIOS ?
                        'https://apps.apple.com/us/app/recyclehub/id1584204305#?platform=iphone':'https://play.google.com/store/apps/details?id=com.beerstudio.recycle_hub',
                        context);
              },
              title: "Оценить приложение",
              icon: Icon(
                svgIcons[7],
                color: kColorGreyDark,
                size: 25,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8),
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     margin: EdgeInsets.only(left: 8),
            //     decoration: BoxDecoration(
            //       border: Border(
            //         bottom: BorderSide(color: Color(0xFF616161), width: 0.5),
            //       ),
            //     ),
            //     child: ListTile(
            //       contentPadding: EdgeInsets.all(0),
            //       title: Text(
            //         'Оценить приложение',
            //         style: TextStyle(fontSize: 16),
            //       ),
            //       onTap: () {
            //         NetworkHelper.openUrl(
            //             'https://apps.apple.com/us/app/recyclehub/id1584204305#?platform=iphone',
            //             context);
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _CommonDrawerCell extends StatelessWidget {
  final String title;
  final Function onTap;
  final Icon icon;
  _CommonDrawerCell({
    this.onTap,
    this.title,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFDFDFDF), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: icon,
              ),
            ),
            Expanded(
              flex: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
