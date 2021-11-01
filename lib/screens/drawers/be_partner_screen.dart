import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/api/request/request.dart';
import 'package:recycle_hub/elements/common_button.dart';
import 'package:recycle_hub/elements/common_cell.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/helpers/network_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:recycle_hub/style/style.dart';
import 'package:recycle_hub/style/theme.dart';

class BePartnerScreen extends StatefulWidget {
  @override
  _BePartnerScreenState createState() => _BePartnerScreenState();
}

class _BePartnerScreenState extends State<BePartnerScreen> {
  TextEditingController _text = TextEditingController();
  bool isLoading = false;
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
            Icons.arrow_back,
            color: kColorWhite,
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
                  hintStyle: kHintTextStyle.copyWith(height: 1.6),
                  
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
                    if (isLoading)
                      Align(
                        alignment: Alignment.center,
                        child: LoaderWidget(
                          color: kColorWhite,
                          size: 30,
                        ),
                      ),
                    if (!isLoading)
                      Text(
                        "Отправить",
                        style: TextStyle(color: kColorWhite, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                      )
                  ],
                ),
                ontap: () async {
                  try {
                    if (_text.text.trim().isEmpty) return;
                    setState(() {
                      isLoading = true;
                    });
                    final response = await CommonRequest.makeRequest(
                      'partners',
                      method: CommonRequestMethod.post,
                      body: {"request_message": _text.text},
                    );
                    if (response.statusCode == 201) {
                      AlertHelper.showMessage(
                        context: context,
                        message: 'Успешно',
                        backColor: kColorGreen,
                      );
                    } else {
                      var data = jsonDecode(response.body);
                      AlertHelper.showMessage(
                        context: context,
                        message: '${data['error']}',
                      );
                    }
                  } catch (e) {
                    print(e.toString());
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
