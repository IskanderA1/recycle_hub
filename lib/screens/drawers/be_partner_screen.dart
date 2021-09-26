import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/elements/common_button.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

class BePartnerScreen extends StatefulWidget {
  @override
  _BePartnerScreenState createState() => _BePartnerScreenState();
}

class _BePartnerScreenState extends State<BePartnerScreen> {
  TextEditingController _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Стать партнером",
          /* style: TextStyle(fontFamily: 'Gillroy'), */
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            AppBarIcons.back,
            color: kColorWhite,
            size: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Отправьте нам сообщение в свободной форме и укажите в письме контакты, по которым с вами можно будет связаться. Как только наш модератор обработает ваш запрос, мы сразу дадим обратную связь',
              style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: TextField(
                controller: _text,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: kColorBlack,
                  fontFamily: 'Gilroy',
                  fontSize: 14,
                ),
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Напишите ваше сообщение тут...',
                  hintStyle: kHintTextStyle,
                ),
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CommonButton(
                height: 50,
                padding: EdgeInsets.all(8),
                backGroundColor: kColorGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Отправить",
                      style: TextStyle(color: kColorWhite, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                    )
                  ],
                ),
                ontap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
