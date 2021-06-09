import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/registration_screen.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

import 'change_pass_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final loginController = TextEditingController()..text  = 'kepeyey591@slowimo.com';
  final passController = TextEditingController()..text = '1234';
  bool _obscureText = true;
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    loginController.clear();
    passController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          return null;
        },
        child: Scaffold(
            body: Container(
          color: kColorWhite,
          height: _size.height,
          width: _size.width,
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Image(
                        width: _size.width,
                        height: _size.height * 0.40,
                        color: Color(0xFFDBCCB6),
                        image: Svg('assets/icons/onboarding_1/Clouds.svg'),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image(
                            image: Svg('assets/icons/reg/reg_logo.svg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Добро пожаловать в',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kColorBlack,
                              fontFamily: 'Gilroy',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'RecycleHub',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF249507),
                              fontFamily: 'Gilroy',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                _buildEmailTF(),
                _buildPasswordTF(),
                _buildLoginBtn(),
                _regFromGoogleVkButtons(),
                _toCreateAcc(),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildEmailTF() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'E-mail',
            style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 40.0,
            child: TextField(
              controller: loginController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'Gilroy',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'E-mail',
                hintStyle: kHintTextStyle,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is UserAuthFailed) {
                    return Text(
                      "Неверный E-mail",
                      style: TextStyle(
                          color: kColorRegGoogle,
                          fontFamily: "GilroyMedium",
                          fontSize: 14),
                    );
                  }
                  return Text(
                    "",
                    style: TextStyle(
                        color: kColorRegGoogle,
                        fontFamily: "GilroyMedium",
                        fontSize: 14),
                  );
                },
              ))
        ],
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Container(
      width: 300,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Пароль',
              style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 40.0,
            width: 300,
            child: TextField(
              controller: passController,
              obscureText: _obscureText,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_obscureText) {
                        _obscureText = false;
                      } else {
                        _obscureText = true;
                      }
                    });
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    size: 20,
                    color: kColorBlack,
                  ),
                ),
                hintText: 'Пароль',
                hintStyle: kHintTextStyle,
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                bloc: authBloc,
                builder: (context, state) {
                  if (state is AuthStateFail) {
                    return Text(
                      "Неверный пароль",
                      style: TextStyle(
                          color: kColorRegGoogle,
                          fontFamily: "GilroyMedium",
                          fontSize: 14),
                    );
                  }
                  return Text(
                    "",
                    style: TextStyle(
                        color: kColorRegGoogle,
                        fontFamily: "GilroyMedium",
                        fontSize: 14),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassScreen()));
                  //authBloc.pickState(UserToForgetScr());
                },
                child: Text(
                  "Забыли пароль?",
                  style: TextStyle(
                      color: kColorBlack,
                      fontSize: 14,
                      fontFamily: 'GilroyMedium'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 300,
      //height: 50,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          authBloc.add(AuthEventLogin(login: loginController.text, password: passController.text));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: kColorGreen,
        child: Text(
          'Войти',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Container _regFromGoogleVkButtons() {
    return Container(
      width: 300,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: kColorRegGoogle),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.googlePlus,
                    color: kColorRegGoogle,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Google",
                    style: TextStyle(
                        color: kColorRegGoogle,
                        fontSize: 13,
                        fontFamily: 'Gilroy'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              width: 140,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xFF2787F5)),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    //color: kColorRegVK,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kColorRegVK,
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.vk,
                        color: kColorWhite,
                        size: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "ВКОНТАКТЕ",
                    style: TextStyle(
                        color: kColorRegVK,
                        fontSize: 13,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toCreateAcc() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Нет учетной записи?",
            style: TextStyle(
                color: kColorGreyDark,
                fontFamily: "GilroyMedium",
                fontSize: 14),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReqistrationScreen()));
            },
            child: Text(
              "Создать",
              style: TextStyle(
                  color: kColorGreen, fontFamily: "GilroyMedium", fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
