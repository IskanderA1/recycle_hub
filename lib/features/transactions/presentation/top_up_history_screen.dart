import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:steps_indicator/steps_indicator.dart';

import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/transaction_model.dart';
import 'package:recycle_hub/features/transactions/domain/model/transaction/transactions_model.dart';
import 'package:recycle_hub/features/transactions/domain/state/transactions_state.dart';
import 'package:recycle_hub/style/theme.dart';

class TopUpHistoryScreen extends StatefulWidget {
  @override
  _TopUpHistoryScreenState createState() => _TopUpHistoryScreenState();
}

class _TopUpHistoryScreenState extends State<TopUpHistoryScreen> {
  ListView cardsList;
  TransactionsState _transactionsState;
  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TransactionsState>(context, listen: false)
        .getTransacts(Hive.box('user').get('user').id);
    _transactionsState ??= Provider.of<TransactionsState>(context);
    _disposer = reaction(
        (_) => _transactionsState.errorMessage,
        (String message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), duration: Duration(seconds: 2))));
  }

  @override
  void dispose() {
    super.dispose();
    _disposer();
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
          "История пополнений",
          style: TextStyle(
              color: kColorWhite,
              fontSize: 18,
              fontFamily: 'GillroyMedium',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: kColorGreyVeryLight,
      body: Observer(builder: (_) {
        if (_transactionsState.state == StoreState.LOADED) {
          return SingleChildScrollView(
              child: TopUpCards(
                  transactions: _transactionsState.transactions.list));
        }
        return LoaderWidget();
      }),
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

class TopUpCards extends StatelessWidget {
  final List<Transaction> transactions;
  const TopUpCards({
    Key key,
    @required this.transactions,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: transactions.length,
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
                                    "Пополнения",
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
                                    //TODO: Дописать количество экокоинов после изменения модели
                                    "${transactions[i].ammount} Экокоинов",
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
                                "Дата:\n${2021}" + ".${4}" + ".${6}",
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
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: StepsIndicator(
                            lineLength: 100,
                            selectedStep: transactions[i].status == 'c' ? 2 : 1,
                            nbSteps: 3,
                            doneStepSize: 15,
                            doneStepColor: transactions[i].status == 'c'
                                ? kColorGreen
                                : kColorRed,
                            doneLineColor: transactions[i].status == 'c'
                                ? kColorGreen
                                : kColorRed,
                            doneLineThickness: 2.5,
                            undoneLineColor: kColorGreyLight,
                            unselectedStepColorIn: kColorGreyLight,
                            unselectedStepColorOut: kColorGreyLight,
                            selectedStepColorOut: transactions[i].status == 'c'
                                ? kColorGreen
                                : kColorRed,
                            selectedStepBorderSize: 0,
                            selectedStepColorIn: transactions[i].status == 'c'
                                ? kColorGreen
                                : kColorRed,
                            unselectedStepSize: 15,
                            undoneLineThickness: 2.5,
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: transactions[i].status == 'c'
                          ? Alignment.centerRight
                          : Alignment.center,
                      child: Padding(
                        padding: transactions[i].status == 'c'
                            ? const EdgeInsets.only(right: 15)
                            : EdgeInsets.zero,
                        child: transactions[i].status == 'c'
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
}
