import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/global_state_bloc.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/icons/user_profile_icons_icons.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
import 'package:recycle_hub/style/theme.dart';

List<IconData> svgIcons = [
  UserProfileIcons.user,
  UserProfileIcons.wallet,
  UserProfileIcons.pie_chart,
  UserProfileIcons.cash_payment,
  UserProfileIcons.ask,
  UserProfileIcons.log_out,
  UserProfileIcons.achievement,
];

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthBloc authBloc;
  AuthState userState;

  //Box<UserModel> userBox;
  @override
  void initState() {
    //userBox = Hive.box('user');
    authBloc = GetIt.I.get<AuthBloc>();
    userState = authBloc.state;

    authBloc.stream.listen((st) {
      if (authBloc.state is AuthStateLogedIn) {
        userState = authBloc.state;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: GetIt.I.get<AuthBloc>(),
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: _size.height,
            width: _size.width,
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Image.asset("svg/Mask Group.png"),
                Container(
                  child: ListView(
                    padding: EdgeInsets.only(left: 17, right: 17, top: 10),
                    children: [
                      buildAppBar(),
                      SizedBox(
                        height: 17,
                      ),
                      buildProfileAvatar(userState.userModel.name, "ЭКОЛОГ",
                          userState.userModel.image),
                      SizedBox(
                        height: 24,
                      ),
                      buildStatus(10, UserService().garbageGiven),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: _size.height * 0.6,
                        padding: EdgeInsets.only(
                            top: 12, bottom: 12, right: 19, left: 19),
                        decoration: BoxDecoration(
                            color: kColorWhite,
                            borderRadius: BorderRadius.circular(16)),
                        child: ListView(
                          padding: EdgeInsets.only(
                              bottom: _size.height * 0.05, top: 5),
                          children: [
                            if (userState is AuthStateGuestAcc)
                              CommonCell(
                                text: 'Авторизоваться',
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AuthScreen()));
                                },
                              ),
                            if (userState is AuthStateLogedIn)
                              buildAchievments(
                                  "Эколог", UserService().garbageGiven),
                            if (userState is AuthStateLogedIn)
                              SizedBox(
                                height: 10,
                              ),
                            if (userState is AuthStateLogedIn)
                              buildMenu(authBloc)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildAppBar() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                GetIt.I
                    .get<ProfileMenuCubit>()
                    .moveTo(ProfileMenuStates.POINT_PROFILE);
              },
              child: Icon(
                Icons.arrow_back_sharp,
                color: kColorWhite,
                size: 30,
              ),
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Профиль",
              style: TextStyle(
                  fontSize: 18,
                  color: kColorWhite,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  Widget buildProfileAvatar(String name, String status, String image) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                    height: 82,
                    width: 82,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kColorPink,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(41),
                      child:
                          /* image != null
                        ? Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(3.0),
                              color: const Color(0xff7c94b6),
                              image: new DecorationImage(
                                image: new NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        :  */
                          Image.network(
                              "https://idsb.tmgrup.com.tr/ly/uploads/images/2020/04/30/33310.jpg"),
                    )),
                Container(
                    padding: EdgeInsets.only(top: 50, left: 50),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 31,
                        width: 31,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kColorWhite),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: kColorGreen,
                          size: 21,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                    color: kColorWhite,
                    fontFamily: 'GillroyMedium',
                    fontSize: 18,
                  )),
              Text(status,
                  style: TextStyle(
                    color: kColorWhite,
                    fontFamily: 'GillroyMedium',
                    fontSize: 12,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget buildStatus(int place, double made) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$place",
                style: TextStyle(color: kColorBlack, fontSize: 28),
              ),
              Text(
                "Место",
                style: TextStyle(color: kColorBlack, fontSize: 16),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    text: '${userState.userModel.ecoCoins}',
                    style: TextStyle(
                        color: kColorGreen,
                        fontSize: 28,
                        fontFamily: 'GilroyMedium'),
                    children: [
                      TextSpan(text: '/', style: TextStyle(color: kColorBlack)),
                      TextSpan(
                          text: '${userState.userModel.freezeEcoCoins}',
                          style: TextStyle(color: kColorRed)),
                    ]),
              ),
              Text(
                "Баланс",
                style: TextStyle(color: kColorBlack, fontSize: 16),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$made",
                style: TextStyle(color: kColorBlack, fontSize: 28),
              ),
              Text(
                "Сдал(кг)",
                style: TextStyle(color: kColorBlack, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildAchievments(String status, double made) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 30,
                width: 30,
                child: Icon(
                  svgIcons[6],
                  color: kColorGreyDark,
                )),
            SizedBox(
              width: 15,
            ),
            Text("Достижения",
                style: TextStyle(color: kColorBlack, fontSize: 14))
          ],
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Статус:",
                    style: TextStyle(
                      color: kColorBlack,
                      fontSize: 14,
                    )),
                SizedBox(width: 14),
                Text(
                  status,
                  style: TextStyle(
                      color: kColorGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        )),
        SizedBox(
          height: 7,
        ),
        _buildProgressIndicator(2),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(
              "Всего сдано: ",
              style: TextStyle(fontSize: 14, color: kColorBlack),
            ),
            Text(
              "$made",
              style: TextStyle(
                  color: kColorBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text("кг",
                style: TextStyle(
                  color: kColorBlack,
                  fontSize: 14,
                ))
          ],
        )
      ],
    );
  }

  Widget _buildProgressIndicator(int lastKGindex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 20,
            width: 47,
            margin: EdgeInsets.only(right: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: (0 < lastKGindex) ? kColorGreen : kLightGrey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: (0 < lastKGindex)
                ? Container()
                : Text(
                    "0кг",
                    style: TextStyle(fontSize: 12, color: kColorGreyDark),
                  )),
        Container(
            height: 20,
            width: 48,
            margin: EdgeInsets.only(right: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (1 < lastKGindex) ? kColorGreen : kLightGrey,
            ),
            child: (1 < lastKGindex)
                ? Container()
                : Text(
                    "50кг",
                    style: TextStyle(fontSize: 12, color: kColorGreyDark),
                  )),
        Container(
            height: 20,
            width: 50,
            margin: EdgeInsets.only(right: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (2 < lastKGindex) ? kColorGreen : kLightGrey,
            ),
            child: (2 < lastKGindex)
                ? Container()
                : Text(
                    "100кг",
                    style: TextStyle(fontSize: 12, color: kColorGreyDark),
                  )),
        Container(
            height: 20,
            width: 48,
            margin: EdgeInsets.only(right: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (3 < lastKGindex) ? kColorGreen : kLightGrey,
            ),
            child: (3 < lastKGindex)
                ? Container()
                : Text(
                    "250кг",
                    style: TextStyle(fontSize: 12, color: kColorGreyDark),
                  )),
        Container(
            height: 20,
            width: 47,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: (4 < lastKGindex) ? kColorGreen : kLightGrey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: (4 < lastKGindex)
                ? Container()
                : Text(
                    "500кг",
                    style: TextStyle(fontSize: 12, color: kColorGreyDark),
                  )),
      ],
    );
  }

  Widget buildMenu(AuthBloc authBloc) {
    return Container(
      padding: EdgeInsets.only(top: 17, bottom: 0, right: 17, left: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: kColorWhite),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            buildListItem(0, "Редактировать профиль"),
            buildListItem(1, "Кошелек"),
            buildListItem(2, "Статистика"),
            buildListItem(3, "Как заработать баллы?"),
            buildListItem(4, "Задать вопрос авторам"),
            buildListItem(5, "Выйти", authBloc: authBloc),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(int index, String text, {AuthBloc authBloc}) {
    return GestureDetector(
      onTap: () {
        if (index == 2)
          GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.STATISTIC);
        else if (index == 3)
          GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.HOWGETCOIN);
        //else if (index == 5)
        //authBloc.authLogOut();
        else if (index == 1)
          GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.PURSE);
        else if (index == 0)
          GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.EDITPROFILE);
        else if (index == 5) {
          if (authBloc != null) {
            authBloc.add(AuthEventLogout());
          }
        }
      },
      child: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: kLightGrey, width: 0.5))),
        child: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                    svgIcons[index],
                    color: kColorGreyDark,
                  )),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(
                  color: index + 2 == svgIcons.length ? kColorRed : kColorBlack,
                ),
              )
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                color: kLightGrey,
              ))
        ]),
      ),
    );
  }

  profileScreenAppBar() {
    return AppBar();
  }
}
