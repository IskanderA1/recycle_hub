import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/auth_user_bloc.dart';
import 'package:recycle_hub/model/authorisation_models/user_response.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/forget_confirm_code_screen.dart';
import 'package:recycle_hub/screens/authorisation_and_registration/reg_confirm_code_screen.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassScreen extends StatefulWidget {
  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController _email = TextEditingController();
  String _isSimilarPasswords = "";
  final _tfKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              body: Container(
                height: ScreenUtil().screenHeight - 85,
                width: ScreenUtil().screenWidth,
                color: Color(0xFFF2F2F2),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: kColorWhite),
                    child: Column(
                      children: [
                        Text(
                          "Сбросить пароль",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kColorBlack,
                              fontFamily: "Gilroy",
                              fontSize: 21,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        RichText(
                            text: TextSpan(
                                text:
                                    "Пожалуйста, введите свой E-mail. Мы пришлем код на вашу почту, чтобы сбросить пароль.",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "GilroyMedium",
                                    color: Color(0xFF8B8B97)))),
                        Spacer(
                          flex: 2,
                        ),
                        _buildEmailTF(),
                        Spacer(
                          flex: 1,
                        ),
                        Text(
                          _isSimilarPasswords,
                          style: TextStyle(
                              color: kColorRegGoogle,
                              fontFamily: "GilroyMedium",
                              fontSize: 14),
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (prevSt, newSt) {
                            if (!(newSt is AuthStateFail)) {
                              return false;
                            }
                            return true;
                          },
                          builder: (context, state) {
                            if (state is AuthStateFail) {
                              return Text(
                                state.error,
                                style:
                                    TextStyle(fontSize: 14, color: kColorRed),
                              );
                            }
                            return Text(
                              "",
                              style: TextStyle(fontSize: 14, color: kColorRed),
                            );
                          },
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        _createButton(),
                        Spacer(
                          flex: 4,
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
            decoration: BoxDecoration(
                color: kColorWhite,
                border: Border.all(
                  width: 1,
                  color: Color(0xFFE0E0E0),
                ),
                borderRadius: BorderRadius.circular(10)),
            height: 50.0,
            child: Form(
              key: _tfKey,
              child: TextFormField(
                controller: _email,
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
                    errorStyle: TextStyle(color: kColorRed)),
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
                validator: (str) {
                  if (str.isEmpty) {
                    return "Введите e-mail";
                  }
                  return null;
                },
              ),
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
          if (_tfKey.currentState.validate()) {
            /*/authBloc.forgetPassCodeSend(_email.text).then((i) {
              if (i == 0) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetConfirmCodeScreen()));
              }
            });*/
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: kColorGreen,
        child: Text(
          'Подтвердить',
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
}
