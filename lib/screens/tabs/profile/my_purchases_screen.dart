import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:recycle_hub/api/services/store_service.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/bloc/cubit/profile_menu_cubit.dart';
import 'package:recycle_hub/bloc/store/store_bloc.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/icons/app_bar_icons_icons.dart';
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
  List<Purchase> list = [];

  Widget cardsList;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  Future<List<Purchase>> _loadPurchases() async {
    try {
      await StoreService().loadPurchases();
      list = StoreService().purchases;
      return list;
    } catch (e) {
      showMessage(context: context, message: 'Не удалось загрузить покупки');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(
            Icons.arrow_back,
            color: kColorWhite,
          ),
          onTap: () => GetIt.I.get<ProfileMenuCubit>().goBack(),
        ),
        title: Text(
          "Мои покупки",
          /* style: TextStyle(color: kColorWhite, fontSize: 18, fontFamily: 'GillroyMedium', fontWeight: FontWeight.bold), */
        ),
        centerTitle: true,
      ),
      backgroundColor: kColorScaffold,
      body: FutureBuilder(
          future: _loadPurchases(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                cardsList = ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.only(
                    bottom: 80,
                  ),
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchaseDetailScreen(
                            purchase: snapshot.data[i],
                          ),
                        ),
                      ),
                      child: PurchaseCell(
                        purchase: list[i],
                      ),
                    );
                  },
                );
              } else {
                cardsList = Container();
              }
              return Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: cardsList,
              );
            }
            return Container();
          }),
    );
  }
}

enum PurchaseStatus { DECLINED, INPROGRESS, COMPLETED }

class PurchaseCell extends StatelessWidget {
  PurchaseCell({this.purchase});
  final Purchase purchase;
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kBorderRadius),
        ),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: kColorWhite),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                      child: Text(
                        purchase.productName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Сумма покупки:",
                        style: const TextStyle(color: kColorGreyLight, fontFamily: 'GillroyMedium'),
                      ),
                      Spacer(),
                      Text(
                        "${purchase.amount}",
                        style: const TextStyle(color: kColorBlack, fontFamily: 'GillroyMedium'),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Осталось:",
                        style: const TextStyle(color: kColorGreyLight, fontFamily: 'GillroyMedium'),
                      ),
                      Spacer(),
                      Flexible(
                        child: AutoSizeText(
                          purchase.daysRest < 0 ? 'Просрочено ' + dateFormat.format(purchase.dateTo) : "${purchase.daysRest}",
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(color: kColorBlack, fontFamily: 'GillroyMedium'),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Дата покупки:",
                        style: const TextStyle(color: kColorGreyLight, fontFamily: 'GillroyMedium'),
                      ),
                      Spacer(),
                      Text(
                        "${purchase.buyDate.day}.${purchase.buyDate.month}.${purchase.buyDate.year}",
                        style: const TextStyle(color: kColorBlack, fontFamily: 'GillroyMedium'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            /* Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ), */
            if (purchase.image != null && purchase.image.isNotEmpty)
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
