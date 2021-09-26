import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recycle_hub/helpers/clipboard_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
import 'package:recycle_hub/model/purchase.dart';
import 'package:recycle_hub/style/theme.dart';

class PurchaseDetailScreen extends StatefulWidget {
  final Purchase purchase;
  const PurchaseDetailScreen({Key key, @required this.purchase}) : super(key: key);
  @override
  _PurchaseDetailScreenState createState() => _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends State<PurchaseDetailScreen> {
  TextEditingController _controller = TextEditingController();
  DateFormat format = DateFormat('dd.MM.yyyy');
  TextStyle titleTextStyle = TextStyle(fontFamily: 'GillroyMedium', fontSize: 16);
  TextStyle valueTextStyle = TextStyle(fontFamily: 'GillroyMedium', fontSize: 16, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    _controller..text = widget.purchase.content;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              AppBarIcons.back,
              color: kColorWhite,
              size: 18,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "Детали покупки",
          /* style: TextStyle(color: kColorWhite, fontSize: 18, fontFamily: 'GillroyMedium', fontWeight: FontWeight.bold), */
        ),
        centerTitle: true,
      ),
      backgroundColor: kColorGreyVeryLight,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
            decoration: BoxDecoration(color: kColorWhite, borderRadius: BorderRadius.circular(kBorderRadius)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /* 
                  Text(
                    "Детали покупки",
                    style: TextStyle(fontFamily: 'GillroyMedium', fontSize: 16),
                  ), */
                  Image.network(
                    'https://cdn2.zp.ru/job/attaches/2020/07/be/76/be764d2d5dd2a062333610f7ba880d56.jpg',
                    height: 200,
                    width: 200,
                  ),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: "${widget.purchase.productName}"),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                      color: kColorGreyLight,
                    ))),
                    style: TextStyle(fontFamily: 'GillroyMedium', fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                        height: 25,
                        width: 25,
                      )),
                      Expanded(
                          flex: 3,
                          child: TextField(
                            readOnly: true,
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kColorBlack, fontSize: 16, fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          saveToCache(widget.purchase.content, context);
                        },
                        child: Icon(
                          Icons.copy_sharp,
                          color: kColorGreyLight,
                          size: 25,
                        ),
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ID купона:",
                          style: titleTextStyle,
                        ),
                        Text(
                          "${widget.purchase.id}",
                          style: valueTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Срок действия до:",
                          style: titleTextStyle,
                        ),
                        Text(
                          "${format.format(widget.purchase.dateTo)}",
                          style: valueTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Сумма покупки:",
                          style: titleTextStyle,
                        ),
                        Text(
                          "${widget.purchase.amount} ЭкоКоинов",
                          style: valueTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Дата покупки:",
                          style: titleTextStyle,
                        ),
                        Text(
                          "${format.format(widget.purchase.buyDate)}",
                          style: valueTextStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
