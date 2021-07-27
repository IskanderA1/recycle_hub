import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/elements/ball.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/helpers/alert_helper.dart';
import 'package:recycle_hub/elements/user_image_picker.dart';
import 'package:recycle_hub/icons/user_profile_icons_icons.dart';
import 'package:recycle_hub/model/user_model.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/auth_screen.dart';
import 'package:recycle_hub/screens/tabs/profile/point_profile_screen.dart';
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
  UserModel userState;
  ScrollController controller = ScrollController();

  //Box<UserModel> userBox;
  @override
  void initState() {
    //userBox = Hive.box('user');
    authBloc = GetIt.I.get<AuthBloc>();
    userState = authBloc.state.userModel;

    authBloc.stream.listen((st) {
      userState = authBloc.state.userModel;
    });
    super.initState();
  }

  Future<void> _refresh() async {
    //GetIt.I.get<AuthBloc>().add(AuthEventRefresh());
    UserModel newUser;
    try {
      newUser = await UserService().userInfo();
      if (newUser != null) {
        userState = newUser;
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: GetIt.I.get<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthStateLogedIn &&
            state.user.userType == UserTypes.admin) {
          return PointProfileScreen();
        }
        return Scaffold(
          body: Container(
            height: _size.height,
            width: _size.width,
            alignment: Alignment.topCenter,
            child: EasyRefresh(
              onRefresh: _refresh,
              footer: ClassicalFooter(),
              header: ClassicalHeader(),
              scrollController: controller,
              child: Stack(
                children: [
                  Image.asset("svg/Mask Group.png"),
                  Container(
                    child: ListView(
                      controller: controller,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 17, right: 17, top: 10),
                      children: [
                        buildAppBar(),
                        SizedBox(
                          height: 17,
                        ),
                        buildProfileAvatar(state.userModel.name, "ЭКОЛОГ",
                            state.userModel.image),
                        SizedBox(
                          height: 24,
                        ),
                        buildStatus(
                            UserService().statistic != null
                                ? UserService().statistic.place
                                : 0,
                            UserService().statistic != null
                                ? UserService().statistic.total
                                : 0),
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
                            controller: controller,
                            padding: EdgeInsets.only(
                                bottom: _size.height * 0.05, top: 5),
                            children: [
                              if (state is AuthStateGuestAcc)
                                CommonCell(
                                  text: 'Авторизоваться',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AuthScreen()));
                                  },
                                ),
                              if (state is AuthStateLogedIn)
                                buildAchievments(
                                    "Эколог", UserService().statistic.total),
                              if (state is AuthStateLogedIn)
                                SizedBox(
                                  height: 10,
                                ),
                              if (state is AuthStateLogedIn) buildMenu(authBloc)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAppBar() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        /* Container(
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
        ), */
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
          UserImagePicker(
            image: image,
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
              InkWell(
                onTap: () {
                  AlertHelper.showErrorAlert(
                      context,
                      "Информация о балансе",
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                BallGreen(
                                  color: kColorRed,
                                ),
                                SizedBox(
                                  width: 32,
                                ),
                                Expanded(
                                  child: Text(
                                    'Красным цветом выделена информация о количестве заблокированных экокоинов.',
                                    overflow: TextOverflow.visible,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                children: [
                                  BallGreen(),
                                  SizedBox(
                                    width: 32,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Зеленым цветом выделена информация о количестве разблокированных экокоинов.',
                                      overflow: TextOverflow.visible,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                },
                child: RichText(
                  text: TextSpan(
                      text: '${userState.ecoCoins}',
                      style: TextStyle(
                          color: kColorGreen,
                          fontSize: 28,
                          fontFamily: 'GilroyMedium'),
                      children: [
                        TextSpan(
                            text: '/', style: TextStyle(color: kColorBlack)),
                        TextSpan(
                            text: '${userState.freezeEcoCoins}',
                            style: TextStyle(color: kColorRed)),
                      ]),
                ),
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
        } else if (index == 4) {
          NetworkHelper.openUrl('http://vk.com/id0', context);
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
