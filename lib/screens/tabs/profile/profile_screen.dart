import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/elements/ball.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/helpers/alert_helper.dart';
import 'package:recycle_hub/elements/user_image_picker.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/icons/nav_bar_icons_icons.dart';
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
    GetIt.I.get<AuthBloc>().add(
          AuthEventRefresh(),
        );
    //UserModel newUser;
    /* try {
      newUser = await UserService().userInfo();
      if (newUser != null) {
        userState = newUser;
      }
    } catch (e) {
      print(e.toString(),);
    } */
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: GetIt.I.get<AuthBloc>(),
      buildWhen: (previous, current) {
        if (previous != current) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        /* if (state is AuthStateLogedIn &&
            state.user.userType == UserTypes.admin) {
          return PointProfileScreen();
        } */
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Профиль",
              /* style: TextStyle(fontWeight: FontWeight.w700), */
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: kColorWhite,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            actions: [
              if (userState != null && userState.role == 'admin')
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    onTap: () {
                      if (GetIt.I.get<AuthBloc>().state.userModel.userType == UserTypes.admin)
                        GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.POINT_PROFILE);
                    },
                    child: Icon(
                      NavBarIcons.app_bar_suffix,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
          body: Container(
            height: _size.height,
            width: _size.width,
            alignment: Alignment.topCenter,
            child: EasyRefresh(
              onRefresh: _refresh,
              footer: ClassicalFooter(),
              header: ClassicalHeader(),
              scrollController: controller,
              child: Container(
                child: ListView(
                  controller: controller,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(right: 16, left: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: buildStatus(state, UserService().statistic != null ? UserService().statistic.place : 0,
                          UserService().statistic != null ? UserService().statistic.total : 0),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    if (state is AuthStateLogedIn)
                      Container(
                        height: 136,
                        padding: EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
                        decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                        ),
                        child: buildAchievments("Эколог", UserService().statistic != null ? UserService().statistic.total : 0),
                      ),
                    if (state is AuthStateLogedIn)
                      SizedBox(
                        height: 16,
                      ),
                    Container(
                      height: _size.height * 0.6,
                      decoration: BoxDecoration(
                        color: kColorWhite,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: ListView(
                        controller: controller,
                        padding: EdgeInsets.only(bottom: _size.height * 0.05, top: 5),
                        children: [
                          if (state is AuthStateGuestAcc)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CommonCell(
                                text: 'Авторизоваться',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AuthScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (state is AuthStateLogedIn) buildMenu(authBloc)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: kColorWhite,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Spacer(),
          Text(
            "Профиль",
            style: TextStyle(fontSize: 20, color: kColorWhite, fontWeight: FontWeight.w700, fontFamily: 'Gilroy'),
            textAlign: TextAlign.start,
          ),
          Spacer(),
          InkWell(
            onTap: () {
              if (GetIt.I.get<AuthBloc>().state.userModel.userType == UserTypes.admin)
                GetIt.I.get<ProfileMenuCubit>().moveTo(ProfileMenuStates.POINT_PROFILE);
            },
            child: Icon(
              NavBarIcons.app_bar_suffix,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStatus(AuthState state, int place, int made) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 16),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserImagePicker(
                      image: state.userModel.image,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userModel.name,
                              style: TextStyle(
                                color: kColorBlack,
                                fontFamily: 'GillroyMedium',
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              "Эколог",
                              style: TextStyle(
                                color: kColorBlack,
                                fontFamily: 'GillroyMedium',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      AlertHelper.showBalanceInfo(context);
                    },
                    child: Icon(
                      Icons.info_outline,
                      color: kColorGreen,
                      size: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
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
                        text: '${userState.ecoCoins}',
                        style: TextStyle(color: kColorGreen, fontSize: 28, fontFamily: 'GilroyMedium'),
                        children: [
                          TextSpan(
                            text: '/',
                            style: TextStyle(color: kColorBlack),
                          ),
                          TextSpan(
                            text: '${userState.freezeEcoCoins}',
                            style: TextStyle(color: kColorRed),
                          ),
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
        ],
      ),
    );
  }

  Widget buildAchievments(String status, int made) {
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
                size: 25,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Достижения",
              style: TextStyle(color: kColorBlack, fontSize: 14),
            )
          ],
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Статус:",
                    style: TextStyle(
                      color: kColorBlack,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 14),
                  Text(
                    status,
                    style: TextStyle(color: kColorGreen, fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 7,
        ),
        ProfileProgressIndicator(total: UserService().statistic != null ? UserService().statistic.total : 0),
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
              style: TextStyle(color: kColorBlack, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "кг",
              style: TextStyle(
                color: kColorBlack,
                fontSize: 14,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget buildMenu(AuthBloc authBloc) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(kBorderRadius), color: kColorWhite),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
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
    return CommonCell(
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
            authBloc.add(
              AuthEventLogout(),
            );
          }
        } else if (index == 4) {
          NetworkHelper.openUrl('http://vk.com/id0', context);
        }
      },
      text: text,
      prefixIcon: Icon(
        svgIcons[index],
        color: kColorIcon,
        size: 25,
      ),
      /* Container(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: kLightGrey, width: 0.5),
          ),
        ),
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
                  size: 25,
                ),
              ),
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
              size: 25,
            ),
          )
        ]),
      ), */
    );
  }
}

class ProfileProgressIndicator extends StatelessWidget {
  const ProfileProgressIndicator({Key key, @required this.total}) : super(key: key);

  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20,
          width: 47,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (0 < total) ? kColorGreen : kLightGrey,
            gradient: (0 < total && total < 50) ? LinearGradient(colors: [kColorGreen, kLightGrey]) : null,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            "0 кг",
            style: TextStyle(fontSize: 12, color: kColorGreyDark),
          ),
        ),
        Container(
          height: 20,
          width: 48,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (50 < total) ? kColorGreen : kLightGrey,
            gradient: (50 < total && total < 100) ? LinearGradient(colors: [kColorGreen, kLightGrey]) : null,
          ),
          child: Text(
            "50 кг",
            style: TextStyle(fontSize: 12, color: kColorGreyDark),
          ),
        ),
        Container(
          height: 20,
          width: 50,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (100 < total) ? kColorGreen : kLightGrey,
            gradient: (100 < total && total < 250) ? LinearGradient(colors: [kColorGreen, kLightGrey]) : null,
          ),
          child: Text(
            "100 кг",
            style: TextStyle(fontSize: 12, color: kColorGreyDark),
          ),
        ),
        Container(
          height: 20,
          width: 48,
          margin: EdgeInsets.only(right: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (250 < total) ? kColorGreen : kLightGrey,
            gradient: (250 < total && total < 500) ? LinearGradient(colors: [kColorGreen, kLightGrey]) : null,
          ),
          child: Text(
            "250 кг",
            style: TextStyle(fontSize: 12, color: kColorGreyDark),
          ),
        ),
        Container(
          height: 20,
          width: 47,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: (500 < total) ? kColorGreen : kLightGrey,
            gradient: (500 < total) ? LinearGradient(colors: [kColorGreen, kLightGrey]) : null,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(
            "500 кг",
            style: TextStyle(fontSize: 12, color: kColorGreyDark),
          ),
        ),
      ],
    );
  }
}
