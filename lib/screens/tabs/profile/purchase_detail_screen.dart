import 'package:flutter/material.dart';
import 'package:recycle_hub/helpers/clipboard_helper.dart';
import 'package:recycle_hub/model/product.dart';
import 'package:recycle_hub/model/purchase.dart';
import '../../../model/transactions/user_transaction_model.dart';
import 'package:recycle_hub/style/theme.dart';

class PurchaseDetailScreen extends StatefulWidget {
  final Purchase purchase;
  const PurchaseDetailScreen(
      {Key key, @required this.purchase})
      : super(key: key);
  @override
  _PurchaseDetailScreenState createState() => _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends State<PurchaseDetailScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller..text = widget.purchase.content;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          "Мои покупки",
          style: TextStyle(
              color: kColorWhite,
              fontSize: 18,
              fontFamily: 'GillroyMedium',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: kColorGreyVeryLight,
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Детали покупки",
                style: TextStyle(fontFamily: 'GillroyMedium', fontSize: 16),
              ),
              Image.network(
                'https://cdn2.zp.ru/job/attaches/2020/07/be/76/be764d2d5dd2a062333610f7ba880d56.jpg',
                height: 200,
                width: 200,
              ),
              Text(
                "${widget.purchase.productName}",
                style: TextStyle(fontFamily: 'GillroyMedium', fontSize: 16),
              ),
              Row(
                children: [
                  SizedBox(),
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
                        style: TextStyle(
                            color: kColorBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      saveToCache(widget.purchase.content, context);
                    },
                    child: Icon(
                      Icons.copy_sharp,
                      color: kColorGreyLight,
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Text(
                    "ID купона:",
                    style: TextStyle(fontFamily: 'GillroyMedium', fontSize: 16),
                  ),
                  Text(
                    "${widget.purchase.id}",
                    style: TextStyle(
                        fontFamily: 'GillroyMedium',
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
