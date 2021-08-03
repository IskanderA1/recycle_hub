import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/registration/registration_bloc.dart';
import 'package:recycle_hub/elements/loader.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
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
              appBar: AppBar(
                toolbarHeight: 50,
                backgroundColor: kColorWhite,
                iconTheme: IconThemeData(color: kColorBlack),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: ScreenUtil().screenHeight - 85,
                  width: ScreenUtil().screenWidth,
                  color: Color(0xFFF2F2F2),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Container(
                      //width: 300,
                      //height: ScreenUtil().screenHeight - 85,
                      padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kColorWhite),
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
                borderRadius: BorderRadius.circular(10)),
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
                borderRadius: BorderRadius.circular(10)),
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
                borderRadius: BorderRadius.circular(10)),
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
                borderRadius: BorderRadius.circular(10)),
            height: 45.0,
            width: 300,
            child: TextField(
              controller: _password,
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
                borderRadius: BorderRadius.circular(10)),
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
          regBloc.add(RegistrationEventRegister(
              username: _email.text,
              name: _name.text,
              surname: _surname.text,
              pass: _password.text,
              code: _refCode.text));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
              Navigator.pop(context);
            },
            child: Text(
              "Войти",
              style: TextStyle(
                  color: kColorGreen, fontFamily: "GilroyMedium", fontSize: 14),
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
              if (_email.text.isEmpty) {
                showMessage(
                    context: context, message: 'Пожалуйста, введите логин');
                return;
              }
              regBloc.add(RegistrationEventHasCode(username: _email.text));
            },
            child: Text(
              "Подтвердить",
              style: TextStyle(
                  color: kColorGreen, fontFamily: "GilroyMedium", fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
