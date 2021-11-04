import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/icons/nav_bar_icons_icons.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  TextEditingController _firstPass = TextEditingController();
  TextEditingController _secondPass = TextEditingController();
  String _isSimilarPasswords = "";

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
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back, size: 24),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: ScreenUtil().screenHeight - 85,
                  width: ScreenUtil().screenWidth,
                  color: Color(0xFFF2F2F2),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 40, 16, 16),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(kBorderRadius), color: kColorWhite),
                      child: Column(
                        children: [
                          Text(
                            "Создать новый пароль",
                            textAlign: TextAlign.center,
                            /* style: TextStyle(
                                color: kColorBlack,
                                fontFamily: "Gilroy",
                                fontSize: 21,
                                fontWeight: FontWeight.w700), */
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          _firstPasswordTF(),
                          Spacer(
                            flex: 1,
                          ),
                          _secondPasswordTF(),
                          Spacer(
                            flex: 1,
                          ),
                          Text(
                            _isSimilarPasswords,
                            style: TextStyle(color: kColorRegGoogle, fontFamily: "GilroyMedium", fontSize: 14),
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
            ),
          )),
    );
  }

  Widget _firstPasswordTF() {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Новый пароль',
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
            height: 50,
            width: 300,
            child: TextField(
              controller: _firstPass,
              obscureText: true,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'Пароль',
                hintStyle: kHintTextStyle,
              ),
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ],
      ),
    );
  }

  Widget _secondPasswordTF() {
    return Container(
      width: 300,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Подтвердите пароль',
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
            height: 50,
            width: 300,
            child: TextField(
              controller: _secondPass,
              obscureText: true,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15),
                hintText: 'Пароль',
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
        onPressed: () async {
          if (_firstPass.text != _secondPass.text) {
            setState(() {
              _isSimilarPasswords = "Пароли не совпадают";
            });
          } else {
            setState(() {
              _isSimilarPasswords = "";
            });
            try {
              await UserService().changePassword(password: _firstPass.text);
              Navigator.pop(context);
            } catch (e) {
              AlertHelper.showMessage(context: context, backColor: kColorRed, message: e.toString());
            }
            
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
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
