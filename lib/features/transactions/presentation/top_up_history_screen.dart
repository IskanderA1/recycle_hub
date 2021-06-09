import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:recycle_hub/api/services/user_service.dart';
import 'package:recycle_hub/helpers/messager_helper.dart';
import 'package:recycle_hub/model/transactions/transaction_model.dart';
import 'package:recycle_hub/screens/tabs/map/widgets/loader_widget.dart';
import 'package:steps_indicator/steps_indicator.dart';
import '../../../model/transactions/user_transaction_model.dart';
import 'package:recycle_hub/bloc/profile_bloc/profile_bloc.dart';
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
        .getTransacts(DateTime.parse("2020-02-27"), DateTime.now());
    _transactionsState ??= Provider.of<TransactionsState>(context);
    _disposer = reaction((_) => _transactionsState.errorMessage,
        (String message) => showMessage(context: context, message: message));
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
          return TopUpCards(transactions: UserService().userTransactions);
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

class TopUpCards extends StatefulWidget {
  final List<UserTransaction> transactions;
  const TopUpCards({
    Key key,
    @required this.transactions,
  }) : super(key: key);

  @override
  _TopUpCardsState createState() => _TopUpCardsState();
}

class _TopUpCardsState extends State<TopUpCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.transactions.length,
          padding: EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int i) {
            return Card(
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
                                    "${widget.transactions[i].ecoCoins} Экокоинов",
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
                            selectedStep:
                                widget.transactions[i].status == 'c' ? 2 : 1,
                            nbSteps: 3,
                            doneStepSize: 15,
                            doneStepColor: widget.transactions[i].status == 'c'
                                ? kColorGreen
                                : kColorRed,
                            doneLineColor: widget.transactions[i].status == 'c'
                                ? kColorGreen
                                : kColorRed,
                            doneLineThickness: 2.5,
                            undoneLineColor: kColorGreyLight,
                            unselectedStepColorIn: kColorGreyLight,
                            unselectedStepColorOut: kColorGreyLight,
                            selectedStepColorOut:
                                widget.transactions[i].status == 'c'
                                    ? kColorGreen
                                    : kColorRed,
                            selectedStepBorderSize: 0,
                            selectedStepColorIn: widget.transactions[i].status == 'c'
                                ? kColorGreen
                                : kColorRed,
                            unselectedStepSize: 15,
                            undoneLineThickness: 2.5,
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: widget.transactions[i].status == 'c'
                          ? Alignment.centerRight
                          : Alignment.center,
                      child: Padding(
                        padding: widget.transactions[i].status == 'c'
                            ? const EdgeInsets.only(right: 15)
                            : EdgeInsets.zero,
                        child: widget.transactions[i].status == 'c'
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
            );
          }),
    );
  }
}
