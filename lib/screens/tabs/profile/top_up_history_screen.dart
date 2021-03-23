import 'package:flutter/material.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/style/theme.dart';
import 'package:steps_indicator/steps_indicator.dart';

import 'purchase_detail_screen.dart';

class TopUpHistoryScreen extends StatefulWidget {
  @override
  _TopUpHistoryScreenState createState() => _TopUpHistoryScreenState();
}

class _TopUpHistoryScreenState extends State<TopUpHistoryScreen> {
  List<TopUp> list = [
    TopUp(operation: "Пополнения", summ: 234.5, status: TopUpStatus.COMPLETED),
    TopUp(operation: "Пополнения", summ: 34.23, status: TopUpStatus.INPROGRESS),
    TopUp(operation: "Пополнения", summ: 34.53, status: TopUpStatus.INPROGRESS),
    TopUp(operation: "Пополнения", summ: 2554.3, status: TopUpStatus.COMPLETED),
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
            /*onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PurchaseDetailScreen(
                          purchase: list[i],
                        ))),*/
            child: Card(
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kColorWhite),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Операция:",
                                    style: const TextStyle(
                                        color: kColorGreyLight,
                                        fontFamily: 'GillroyMedium'),
                                  ),
                                  Text(
                                    list[i].operation,
                                    style: const TextStyle(
                                        color: kColorBlack,
                                        fontFamily: 'GillroyMedium'),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Общая сумма: ",
                                    style: const TextStyle(
                                        color: kColorGreyLight,
                                        fontFamily: 'GillroyMedium'),
                                  ),
                                  Text(
                                    "${list[i].summ} Экокоинов",
                                    style: const TextStyle(
                                        color: kColorBlack,
                                        fontFamily: 'GillroyMedium'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Статус:",
                          style: const TextStyle(
                              color: kColorGreyLight,
                              fontFamily: 'GillroyMedium'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: StepsIndicator(
                            lineLength: 100,
                            selectedStep:
                                list[i].status == TopUpStatus.COMPLETED ? 2 : 1,
                            nbSteps: 3,
                            doneStepSize: 15,
                            doneStepColor: list[i].status == TopUpStatus.COMPLETED
                                ? kColorGreen
                                : kColorRed,
                            doneLineColor: list[i].status == TopUpStatus.COMPLETED
                                ? kColorGreen
                                : kColorRed,
                            doneLineThickness: 2.5,
                            undoneLineColor: kColorGreyLight,
                            unselectedStepColorIn: kColorGreyLight,
                            unselectedStepColorOut: kColorGreyLight,
                            selectedStepColorOut:
                                list[i].status == TopUpStatus.COMPLETED
                                    ? kColorGreen
                                    : kColorRed,
                            selectedStepBorderSize: 0,
                            selectedStepColorIn:
                                list[i].status == TopUpStatus.COMPLETED
                                    ? kColorGreen
                                    : kColorRed,
                            unselectedStepSize: 15,
                            undoneLineThickness: 2.5,
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: list[i].status == TopUpStatus.COMPLETED
                          ? Alignment.centerRight
                          : Alignment.center,
                      child: Padding(
                        padding: list[i].status == TopUpStatus.COMPLETED
                            ? const EdgeInsets.only(right: 15) : EdgeInsets.zero,
                        child: list[i].status == TopUpStatus.COMPLETED
                            ? Text(
                                "Завершено",
                                style: const TextStyle(
                                    fontFamily: 'Gillroy',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: kColorGreen),
                              )
                            : Text(
                                "В ожидании",
                                style: const TextStyle(
                                    fontFamily: 'Gillroy',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: kColorRed),
                              ),
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

class TopUp {
  String operation;
  double summ;
  TopUpStatus status;
  DateTime date = DateTime.now();
  TopUp({
    @required this.operation,
    @required this.summ,
    @required this.status,
  });
}

enum TopUpStatus { INPROGRESS, COMPLETED }
