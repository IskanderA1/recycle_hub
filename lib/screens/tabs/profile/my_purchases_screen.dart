import 'package:flutter/material.dart';
import 'package:recycle_hub/api/services/store_service.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/model/purchase.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'purchase_detail_screen.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/style/theme.dart';
import '../../../model/transactions/user_transaction_model.dart';

class MyPurchasesScreen extends StatefulWidget {
  @override
  _MyPurchasesScreenState createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
  List<Purchase> list = StoreService().purchases;

  ListView cardsList;

  @override
  void initState() {
    super.initState();
    cardsList = ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PurchaseDetailScreen(purchase: list[i]))),
              child: PurchaseCell(
                purchase: list[i],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
          onPressed: () =>
              profileMenuBloc.mapEventToState(ProfileMenuStates.MENU),
        ),
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
      body: SingleChildScrollView(child: cardsList),
    );
  }
}

enum PurchaseStatus { DECLINED, INPROGRESS, COMPLETED }

class PurchaseCell extends StatelessWidget {
  const PurchaseCell({this.purchase});
  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: kColorWhite),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Сумма покупки:",
                        style: const TextStyle(
                            color: kColorGreyLight,
                            fontFamily: 'GillroyMedium'),
                      ),
                      Text(
                        "${purchase.amount}" + r'$',
                        style: const TextStyle(
                            color: kColorBlack, fontFamily: 'GillroyMedium'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Осталось:",
                        style: const TextStyle(
                            color: kColorGreyLight,
                            fontFamily: 'GillroyMedium'),
                      ),
                      Text(
                        "${purchase.daysRest}",
                        style: const TextStyle(
                            color: kColorBlack, fontFamily: 'GillroyMedium'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Дата покупки:",
                        style: const TextStyle(
                            color: kColorGreyLight,
                            fontFamily: 'GillroyMedium'),
                      ),
                      Text(
                        "${purchase.buyDate.day}.${purchase.buyDate.month}.${purchase.buyDate.year}",
                        style: const TextStyle(
                            color: kColorBlack, fontFamily: 'GillroyMedium'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.network(
                'https://cdn2.zp.ru/job/attaches/2020/07/be/76/be764d2d5dd2a062333610f7ba880d56.jpg',
                height: 80,
                width: 80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
