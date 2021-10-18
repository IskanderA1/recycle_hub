import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/registration/registration_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/icons/nav_bar_icons_icons.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'reg_confirm_code_screen.dart';

class ReqistrationScreen extends StatefulWidget {
  @override
  _ReqistrationScreenState createState() => _ReqistrationScreenState();
}

class _ReqistrationScreenState extends State<ReqistrationScreen> {
  TextEditingController _surname = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _refCode = TextEditingController();
  bool _obscureText = true;

  RegistrationBloc regBloc;

  GlobalKey<FormState> _passKey = GlobalKey<FormState>();

  Pattern patternNum = r'^(?=.*[0-9])';
  Pattern patternAlphabet = r'^(?=.*[a-z])';

  String errorText = "";

  @override
  void initState() {
    regBloc = GetIt.I.get<RegistrationBloc>();
    regBloc.add(RegistrationEventInit());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: regBloc,
      builder: (context, state) {
        if (state is RegistrationStateNeedConfirm) {
          return ConfirmCodeScreen();
        } else if (state is RegistrationStateInitial) {
          return _buildRegistrationScreen();
        } else if (state is RegistrationStateLoading) {
          return buildLoadingScaffold();
        }
        return _buildRegistrationScreen();
      },
      listener: (context, state) {
        if (state is RegistrationStateError) {
          showMessage(context: context, message: state.error.toString());
        } else if (state is RegistrationStateConfirmed) {
          Navigator.pop(context);
        }
      },
    );
  }

  _buildRegistrationScreen() {
    Size _size = MediaQuery.of(context).size;
    ScreenUtil _util = ScreenUtil();
    return SafeArea(
      child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return;
          },
          child: GestureDetector(
            onTap: () {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: kColorScaffold,
              appBar: AppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(NavBarIcons.left),
                ),
              ),
              body: Container(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 85,
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(kBorderRadius), color: kColorWhite),
                    child: Column(
                      children: [
                        _nameEnterTF(),
                        Spacer(
                          flex: 1,
                        ),
                        _surnameEnterTF(),
                        Spacer(
                          flex: 1,
                        ),
                        _emailEnterTF(),
                        Spacer(
                          flex: 1,
                        ),
                        _buildPasswordTF(),
                        Spacer(
                          flex: 1,
                        ),
                        _refCodeEnterTF(),
                        Spacer(
                          flex: 2,
                        ),
                        /*StreamBuilder(
                          stream: authBloc.subject,
                          builder: (BuildContext ctx,
                              AsyncSnapshot<UserResponse> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data is UserRegFailed) {
                                return Text(
                                  snapshot.data.error,
                                  style: TextStyle(
                                      fontSize: 14, color: kColorRed),
                                );
                              }
                            }
                            return Text(
                              "",
                              style:
                                  TextStyle(fontSize: 14, color: kColorRed),
                            );
                          },
                        ),*/
                        Spacer(
                          flex: 2,
                        ),
                        _createButton(),
                        Spacer(
                          flex: 1,
                        ),
                        _toAuthScreen(),
                        SizedBox(
                          height: 20,
                        ),
                        _toConfirmScreen(),
                        Spacer(
                          flex: 6,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Container _nameEnterTF() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Имя',
            style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: kColorWhite,
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE0E0E0),
                ),
                borderRadius: BorderRadius.circular(kBorderRadius)),
            height: 45.0,
            child: TextField(
              controller: _name,
              keyboardType: TextInputType.name,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'Gilroy',
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'Имя',
                hintStyle: kHintTextStyle,
              ),
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container _surnameEnterTF() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Фамилия',
            style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: kColorWhite,
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE0E0E0),
                ),
                borderRadius: BorderRadius.circular(kBorderRadius)),
            height: 45.0,
            child: TextField(
              controller: _surname,
              keyboardType: TextInputType.name,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'Gilroy',
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'Фамилия',
                hintStyle: kHintTextStyle,
              ),
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Container _emailEnterTF() {
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
            decoration: BoxDecoration(
                color: kColorWhite,
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE0E0E0),
                ),
                borderRadius: BorderRadius.circular(kBorderRadius)),
            height: 45.0,
            child: TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'Gilroy',
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'E-mail',
                hintStyle: kHintTextStyle,
              ),
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Container(
      width: 300,
      child: Column(
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
            decoration: BoxDecoration(
                color: kColorWhite,
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE0E0E0),
                ),
                borderRadius: BorderRadius.circular(kBorderRadius)),
            height: 45.0,
            width: 300,
            child: Form(
              key: _passKey,
              child: TextFormField(
                controller: _password,
                obscureText: _obscureText,
                validator: (str) {
                  if (str.length < 8) {
                    errorText = 'Пароль должен содержать как минимум 8 символов';
                  } else if (!RegExp(patternNum).hasMatch(str)) {
                    errorText = 'Пароль должен содержать хотя-бы 1 цифру';
                  } else if (!RegExp(patternAlphabet).hasMatch(str)) {
                    errorText = 'Пароль должен содержать хотя-бы 1 букву';
                  }
                  setState(() {
                    errorText = '';
                  });
                  return null;
                },
                style: TextStyle(
                  color: kColorBlack,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15),
                  errorStyle: TextStyle(fontSize: 12),
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
          ),
          if (errorText.isNotEmpty)
            Text(
              errorText,
              style: TextStyle(color: kColorRed, fontSize: 12),
            ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _refCodeEnterTF() {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Реферальный код (не обязательно)',
              style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: kColorWhite,
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE0E0E0),
                ),
                borderRadius: BorderRadius.circular(kBorderRadius)),
            height: 45.0,
            width: 300,
            child: TextField(
              controller: _refCode,
              obscureText: _obscureText,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'Реферальный код',
                hintStyle: kHintTextStyle,
              ),
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 300,
      //height: 50,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _passKey.currentState.validate();
          if (errorText.isNotEmpty) {
            showMessage(message: "Пароль не соответствует требованиям", context: context);
            return;
          }
          regBloc.add(
              RegistrationEventRegister(username: _email.text, name: _name.text, surname: _surname.text, pass: _password.text, code: _refCode.text));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        color: kColorGreen,
        child: Text(
          'Создать аккаунт',
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

  Widget _toAuthScreen() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Уже есть аккаунт?",
            style: TextStyle(color: kColorGreyDark, fontFamily: "GilroyMedium", fontSize: 14),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "Войти",
              style: TextStyle(color: kColorGreen, fontFamily: "GilroyMedium", fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toConfirmScreen() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Есть код?",
            style: TextStyle(color: kColorGreyDark, fontFamily: "GilroyMedium", fontSize: 14),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              if (_email.text.isEmpty) {
                showMessage(context: context, message: 'Пожалуйста, введите логин');
                return;
              }
              regBloc.add(RegistrationEventHasCode(username: _email.text));
            },
            child: Text(
              "Подтвердить",
              style: TextStyle(color: kColorGreen, fontFamily: "GilroyMedium", fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
