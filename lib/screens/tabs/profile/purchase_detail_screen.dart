import 'package:flutter/material.dart';

import 'package:recycle_hub/screens/tabs/profile/my_purchases_screen.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PurchaseDetailScreen extends StatefulWidget {
  final Purchase purchase;
  const PurchaseDetailScreen({
    Key key,
    @required this.purchase,
  }) : super(key: key);
  @override
  _PurchaseDetailScreenState createState() => _PurchaseDetailScreenState();
}

class _PurchaseDetailScreenState extends State<PurchaseDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
              Text("Покупка id#${widget.purchase.id}", style: TextStyle(
                fontFamily: 'GillroyMedium',
                fontSize: 16
              ),),
              Text("Детали покупки", style: TextStyle(
                fontFamily: 'GillroyMedium',
                fontSize: 16
              ),),
              Text("общая сумма", style: TextStyle(
                fontFamily: 'GillroyMedium',
                fontSize: 16
              ),),
              Text("Способ оплаты", style: TextStyle(
                fontFamily: 'GillroyMedium',
                fontSize: 16
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
