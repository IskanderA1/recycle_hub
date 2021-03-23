import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

class OfferNewPointScreen extends StatefulWidget {
  @override
  _OfferNewPointScreenState createState() => _OfferNewPointScreenState();
}

class _OfferNewPointScreenState extends State<OfferNewPointScreen> {
  TextEditingController _address = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _companyName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        profileMenuBloc.mapEventToState(ProfileMenuStates.BACK);
        return;
      },
      child: Scaffold(
        backgroundColor: kColorWhite,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Добавить пункт приема",
            style: TextStyle(fontFamily: 'Gillroy'),
          ),
          leading: GestureDetector(
            onTap: () {
              profileMenuBloc.mapEventToState(ProfileMenuStates.BACK);
            },
            child: Icon(
              Icons.arrow_back,
              color: kColorWhite,
              size: 35,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              height: ScreenUtil().screenHeight-90,
              width: double.infinity,
              color: Color(0xFFF2F2F2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: kColorWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(
                      children: [
                        Text(
                          "Заполните нужную информацию\nо пункте приёма:",
                          style: TextStyle(
                              fontFamily: 'Gillroy',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: OfferPonitTextFields(
                            address: _address,
                            hintText: "Адрес",
                            adText: "Адрес пункта приема",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: OfferPonitTextFields(
                            address: _phoneNumber,
                            hintText: "Номер телефона",
                            adText: "Номер телефона",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: OfferPonitTextFields(
                            address: _companyName,
                            hintText: "Название",
                            adText: "Название организации",
                          ),
                        ),
                        Text(
                          "Добавить фото",
                          style: TextStyle(
                              fontFamily: 'GillroyMedium',
                              fontSize: 16,
                              color: Color(0xFF8D8D8D)),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 45,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: kColorGreen,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Из устройства",
                                      style: TextStyle(
                                          color: kColorWhite,
                                          fontFamily: 'GillroyMedium',
                                          fontSize: 14),
                                    ),
                                  ),
                                )),
                            Spacer(),
                            GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 45,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFECECEC),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                    child: Text(
                                      "Камера",
                                      style: TextStyle(
                                          color: kColorBlack,
                                          fontFamily: 'GillroyMedium',
                                          fontSize: 14),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: kColorGreen, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Ваш запрос будет отправлен модератору",
                              style: TextStyle(
                                  fontSize: 13, fontFamily: 'GillroyMedium'),
                            )
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                                color: kColorGreen,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                              child: Text("Отправить",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: kColorWhite,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'GillroyMedium')),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OfferPonitTextFields extends StatelessWidget {
  const OfferPonitTextFields({
    Key key,
    @required TextEditingController address,
    @required this.hintText,
    @required this.adText,
  })  : _address = address,
        super(key: key);

  final TextEditingController _address;
  final String hintText;
  final String adText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            adText,
            style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
          ),
          SizedBox(height: 15.0),
          Container(
            alignment: Alignment.centerLeft,
            height: 45.0,
            child: TextField(
              controller: _address,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: kColorBlack,
                fontFamily: 'Gilroy',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xFFECECEC), width: 1)),
                contentPadding: EdgeInsets.only(left: 15),
                hintText: hintText,
                hintStyle: kHintTextStyle,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
