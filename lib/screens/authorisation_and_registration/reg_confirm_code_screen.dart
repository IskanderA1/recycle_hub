import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_hub/bloc/auth/auth_bloc.dart';
import 'package:recycle_hub/bloc/registration/registration_bloc.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ConfirmCodeScreen extends StatefulWidget {
  @override
  _ConfirmCodeScreenState createState() => _ConfirmCodeScreenState();
}

class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  TextEditingController _code = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '######', filter: {"#": RegExp(r'[0-9]')});
  final _tfKey = GlobalKey<FormState>();

  RegistrationBloc regBloc;

  @override
  void initState() {
    regBloc = GetIt.I.get<RegistrationBloc>();
    super.initState();
  }

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
                          "Введите код из письма",
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
                        _codeEnterTF(),
                        Spacer(
                          flex: 1,
                        ),
                        /*StreamBuilder(
                          stream: authBloc.subject,
                          builder: (BuildContext ctx,
                              AsyncSnapshot<UserResponse> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data is UserCodeConfirmFailed) {
                                return Text(
                                  snapshot.data.error,
                                  style:
                                      TextStyle(fontSize: 14, color: kColorRed),
                                );
                              }
                              if (snapshot.data is UserLoading) {
                                return Text(
                                  snapshot.data.error,
                                  style:
                                      TextStyle(fontSize: 14, color: kColorRed),
                                );
                              }
                            }
                            return Text(
                              "",
                              style: TextStyle(fontSize: 14, color: kColorRed),
                            );
                          },
                        ),*/
                        Spacer(flex: 1),
                        _confirmButton(),
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

  Widget _codeEnterTF() {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Код",
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
                controller: _code,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: kColorBlack,
                  fontFamily: 'Gilroy',
                  fontSize: 16,
                ),
                inputFormatters: [maskFormatter],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Код',
                    hintStyle: kHintTextStyle,
                    errorStyle: TextStyle(color: kColorRed)),
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
                validator: (str) {
                  if (str.length < 6) {
                    return "Введите код";
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

  Widget _confirmButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 300,
      //height: 50,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_tfKey.currentState.validate()) {
            regBloc.add(RegistrationEventConfirm(code: _code.text));
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
