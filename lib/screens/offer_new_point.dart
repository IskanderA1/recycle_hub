import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle_hub/elements/common_button.dart';
import 'package:recycle_hub/helpers/image_picker.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/model/new_point_model.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

class OfferNewPointScreen extends StatefulWidget {
  final Function onBack;
  const OfferNewPointScreen({
    Key key,
    @required this.onBack,
  }) : super(key: key);
  @override
  _OfferNewPointScreenState createState() => _OfferNewPointScreenState();
}

class _OfferNewPointScreenState extends State<OfferNewPointScreen> {
  TextEditingController _address = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _discription = TextEditingController();
  File _image;
  NewPoint newPoint;
  final picker = ImagePicker();

  Future _getImage() async {
    try {
      final img = await FilePicker.getImage();
      setState(() {
        _image = img;
      });
    } catch (e) {}
  }

  Future _getImageFromStorage() async {
    try {
      final img = await FilePicker.getImageFromStorage();
      setState(() {
        _image = img;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.onBack();
        return;
      },
      child: Scaffold(
        backgroundColor: kColorGreyVeryLight,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Добавить пункт приема",
            /* style: TextStyle(fontFamily: 'Gillroy'), */
          ),
          leading: GestureDetector(
            onTap: () {
              widget.onBack();
            },
            child: Icon(
              AppBarIcons.back,
              color: kColorWhite,
              size: 35,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kBorderRadius),
                    topRight: Radius.circular(kBorderRadius),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Заполните нужную информацию\nо пункте приёма:",
                        style: TextStyle(fontFamily: 'Gillroy', fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: OfferPonitTextFields(
                          address: _address,
                          hintText: "Адрес",
                          adText: "Адрес пункта приема",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: OfferPonitTextFields(
                          address: _phoneNumber,
                          hintText: "Номер телефона",
                          adText: "Номер телефона",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: OfferPonitTextFields(
                          address: _discription,
                          hintText: "Описание",
                          adText: "Описание пункта приема",
                        ),
                      ),
                      _image != null
                          ? Image.file(
                              _image,
                              fit: BoxFit.scaleDown,
                              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                if (wasSynchronouslyLoaded ?? false) {
                                  return child;
                                }
                                return AnimatedOpacity(
                                  child: Stack(
                                    children: <Widget>[
                                      child,
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _image = null;
                                              });
                                            },
                                            child: Icon(Icons.close),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  opacity: frame == null ? 0 : 1,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeOut,
                                );
                              },
                            )
                          : Container(),
                      Center(
                        child: Text(
                          "Добавить фото",
                          style: TextStyle(fontFamily: 'GillroyMedium', fontSize: 16, color: Color(0xFF8D8D8D)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          CommonButton(
                              width: 145,
                              height: 50,
                              ontap: () => _getImageFromStorage(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Из устройства",
                                    style: TextStyle(color: kColorWhite, fontFamily: 'GillroyMedium', fontSize: 14),
                                  ),
                                ],
                              )),
                          Spacer(),
                          CommonButton(
                            width: 145,
                            height: 50,
                            backGroundColor: kColorGreyVeryLight,
                            ontap: () => _getImage(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Камера",
                                  style: TextStyle(color: kColorBlack, fontFamily: 'GillroyMedium', fontSize: 14),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(color: kColorGreen, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Ваш запрос будет отправлен модератору",
                            style: TextStyle(fontSize: 13, fontFamily: 'GillroyMedium'),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      CommonButton(
                        width: 300,
                        height: 50,
                        ontap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: kColorGreen,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text("Отправить",
                                style: TextStyle(fontSize: 18, color: kColorWhite, fontWeight: FontWeight.bold, fontFamily: 'GillroyMedium')),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                    ],
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
                border: OutlineInputBorder(borderSide: BorderSide(color: const Color(0xFFECECEC), width: 1)),
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
