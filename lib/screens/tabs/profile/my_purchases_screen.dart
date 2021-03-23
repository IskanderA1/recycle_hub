import 'package:flutter/material.dart';
import 'purchase_detail_screen.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/style/theme.dart';

class MyPurchasesScreen extends StatefulWidget {
  @override
  _MyPurchasesScreenState createState() => _MyPurchasesScreenState();
}

class _MyPurchasesScreenState extends State<MyPurchasesScreen> {
  List<Purchase> list = [
    Purchase(
        id: "214352",
        summ: 123.4,
        date: DateTime.utc(2021, 5, 12),
        status: PurchaseStatus.DECLINED),
    Purchase(
        id: "245445",
        summ: 334.4,
        date: DateTime.utc(2021, 5, 12),
        status: PurchaseStatus.INPROGRESS),
    Purchase(
        id: "213453",
        summ: 123.4,
        date: DateTime.utc(2021, 5, 12),
        status: PurchaseStatus.COMPLETED),
    Purchase(
        id: "214454",
        summ: 123.4,
        date: DateTime.utc(2021, 5, 12),
        status: PurchaseStatus.INPROGRESS)
  ];

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
                    builder: (context) => PurchaseDetailScreen(
                          purchase: list[i],
                        ))),
            child: Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kColorWhite),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Покупка ID:",
                                style: const TextStyle(
                                    color: kColorGreyLight,
                                    fontFamily: 'GillroyMedium'),
                              ),
                              Text(
                                list[i].id,
                                style: const TextStyle(
                                    color: kColorBlack,
                                    fontFamily: 'GillroyMedium'),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Общая сумма:",
                                style: const TextStyle(
                                    color: kColorGreyLight,
                                    fontFamily: 'GillroyMedium'),
                              ),
                              Text(
                                "${list[i].summ}" + r'$',
                                style: const TextStyle(
                                    color: kColorBlack,
                                    fontFamily: 'GillroyMedium'),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Статус:",
                                style: const TextStyle(
                                    color: kColorGreyLight,
                                    fontFamily: 'GillroyMedium'),
                              ),
                              Text(
                                list[i].status == PurchaseStatus.COMPLETED
                                    ? "Завершено"
                                    : list[i].status == PurchaseStatus.DECLINED
                                        ? "Отменено"
                                        : "В процессе",
                                style: TextStyle(
                                    color: list[i].status ==
                                            PurchaseStatus.COMPLETED
                                        ? kColorGreen
                                        : list[i].status ==
                                                PurchaseStatus.DECLINED
                                            ? kColorRed
                                            : kColorGreenYellow,
                                    fontFamily: 'GillroyMedium'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Дата:\n${list[i].date.year}" +
                                ".${list[i].date.month}" +
                                ".${list[i].date.day}",
                            style: TextStyle(
                                color: kColorGreyLight,
                                fontFamily: 'GillroyMedium'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kColorWhite, size: 25),
          onPressed: () =>
              profileMenuBloc.mapEventToState(ProfileMenuStates.BACK),
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

class Purchase {
  String id;
  double summ;
  PurchaseStatus status;
  DateTime date;
  String sStatus;
  Purchase(
      {@required this.id,
      @required this.summ,
      @required this.date,
      @required this.status});
}

enum PurchaseStatus { DECLINED, INPROGRESS, COMPLETED }
